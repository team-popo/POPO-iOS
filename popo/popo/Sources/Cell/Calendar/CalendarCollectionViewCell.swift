//
//  CalendarCollectionViewCell.swift
//  popo
//
//  Created by 초이 on 2021/10/01.
//

import UIKit
import Kingfisher

class CalendarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        self.imageBgView.makeRounded(radius: 5)
        self.thumbImageView.makeRounded(radius: 5)
    }
    
    func initCell(tracker: Tracker) {
        
        if tracker.id != -1 {
            dateLabel.isHidden = true
            thumbImageView.isHidden = false
            thumbImageView.kf.setImage(with: URL(string: tracker.image))
            imageBgView.backgroundColor = UIColor.white
        } else {
            dateLabel.isHidden = false
            dateLabel.text = "\(tracker.date)"
            thumbImageView.isHidden = true
            imageBgView.backgroundColor = UIColor.emptyCalendarBg
            
        }
    }

}
