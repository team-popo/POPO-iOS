//
//  OptionAppendView.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/13.
//

import Foundation
import UIKit

class PlusOptionView: UIView {
    let plusButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in
            NotificationCenter.default.post(name: .plusOption, object: nil)
        }))
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("", for: .normal)
        button.tintColor = .gray
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .bold), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUI() {
        self.makeRounded(radius: 10)
        self.backgroundColor = .systemGray6
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.borderWidth = 1
    }
    
    private func setConstraint() {
        self.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
