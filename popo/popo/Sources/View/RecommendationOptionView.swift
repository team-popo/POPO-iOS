//
//  RecommendationOptionView.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/13.
//

import Foundation
import UIKit

class RecommendationOptionView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "제목"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(sendRemoveOptionNotificaiton), for: .touchUpInside)
        return button
    }()
    
    init(title: String) {
        super.init(frame: CGRect())
        setUI()
        setConstraint()
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUI() {
        self.makeRounded(radius: 10)
        self.backgroundColor = UIColor(named: "popoPurple")
    }
    
    private func setConstraint() {
        self.addSubview(titleLabel)
        self.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    func getOptionTitle() -> String {
        if let title = titleLabel.text {
            return title
        }
        return ""
    }
    
    @objc
    private func sendRemoveOptionNotificaiton() {
        NotificationCenter.default.post(name: .removeOption, object: titleLabel.text)
    }
}
