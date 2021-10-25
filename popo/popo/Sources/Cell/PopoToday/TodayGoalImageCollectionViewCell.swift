//
//  ParticularTodayImageCollectionViewCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/20.
//

import UIKit
import Kingfisher

class TodayGoalImageCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var goalBolderView: UIView!
    @IBOutlet weak var goalContentTextView: UITextView!
    @IBOutlet weak var acheivementBolderView: UIView!
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
        imageView.makeRounded(radius: 30)
    }
    
    func initCell(_ url: String,
                  _ goalContent: String,
                  _ acheivementContent: String) {
        if let url = URL(string: url) {
            imageView.kf.setImage(with: url)
        }
        goalContentTextView.text = goalContent
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
