//
//  RecommendationCollectionViewCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/13.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var recommendationOptionsLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.2) {
                    self.bgView.backgroundColor = UIColor(named: "popoPurple")
                    self.bgView.layer.borderColor = UIColor(named: "popoPurple")?.cgColor
                    self.recommendationOptionsLabel.textColor = .white
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.bgView.backgroundColor = .systemGray6
                    self.bgView.layer.borderColor = UIColor.systemGray5.cgColor
                    self.recommendationOptionsLabel.textColor = .gray
                }
            }
        }
    }
}

// MARK: - RecommendationCollectionViewCell

extension RecommendationCollectionViewCell {
    private func setUI() {
        bgView.makeRounded(radius: 15)
        bgView.backgroundColor = .systemGray6
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.systemGray5.cgColor
        recommendationOptionsLabel.textColor = .gray
    }
    func initCell(_ recommendationOption: String) {
        recommendationOptionsLabel.text = recommendationOption
    }
}
