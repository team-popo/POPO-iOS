//
//  StarOptionCollectionViewCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/25.
//

import UIKit

class StarOptionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var starList: [UIButton]!

    // MARK: - Cell Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: - Functions
    
    func initUI() {
        borderView.makeRoundedWithBorder(radius: 30, color: UIColor.systemGray2.cgColor)
        editButton.isHidden = true
    }
    
    func initCell(title: String, content: String) {
        titleLabel.text = title
        if let stars = Int(content) {
            initStar(stars: stars)
        }
    }
    
    func initEditingStatus(isEditing: Bool) {
//        editButton.isHidden = isEditing
        starList.forEach {
            $0.isUserInteractionEnabled = isEditing
        }
    }
    
    private func initStar(stars: Int) {
        if stars != 0 {
            for star in 0..<stars {
                starList[star].setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchEditButton(_ sender: UIButton) {
        
    }
}
