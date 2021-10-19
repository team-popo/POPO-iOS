//
//  TodayImageCollectionViewCell.swift
//  popo
//
//  Created by 초이 on 2021/10/19.
//

import UIKit

class TodayImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var todayImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions
    
    func initCell(image: UIImage, date: String) {
        todayImageView.image = image
        dateLabel.text = date
    }
    
    // MARK: - @IBAction Function

}
