//
//  ParticularTodayImageCollectionViewCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/20.
//

import UIKit

class TodayGoalImageCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var goalBolderView: UIView!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var goalContentTextView: UITextView!
    @IBOutlet weak var acheivementBolderView: UIView!
    @IBOutlet weak var acheivementTitleLabel: UILabel!
    @IBOutlet weak var acheivementContentTextView: UITextView!
    
    // MARK: - Cell Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    private func setUI() {
        goalBolderView.makeRoundedWithBorder(radius: 30, color: UIColor.systemGray2.cgColor)
        goalContentTextView.textContainerInset = .zero
        
        acheivementBolderView.makeRoundedWithBorder(radius: 30, color: UIColor.systemGray2.cgColor)
        acheivementContentTextView.textContainerInset = .zero
    }
    
    func initCell(_ url: String,
                  _ goalTitle: String,
                  _ goadlContent: String,
                  _ acheivementTitle: String,
                  _ acheivementContent: String) {
        if let url = URL(string: url) {
            imageView.kf.setImage(with: url)
        }
        goalTitleLabel.text = goalTitle
        goalContentTextView.text = goadlContent
        acheivementTitleLabel.text = acheivementTitle
        acheivementContentTextView.text = acheivementContent
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchGoalEditButton(_ sender: UIButton) {
        // TODO: textView edit
    }
    @IBAction func touchAcheivementEditButton(_ sender: UIButton) {
        // TODO: textView edit
    }
    
}
