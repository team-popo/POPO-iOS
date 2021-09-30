//
//  CategoryCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/21.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var whiteBgView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    // MARK: - Cell Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Methods
    
    private func setUI() {
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        whiteBgView.makeRounded(radius: 20)
    }

    func initCell(_ image: String, _ text: String) {
        categoryLabel.text = text
        if let image = UIImage(named: image) {
            categoryImage.image = image
        }
    }
}
