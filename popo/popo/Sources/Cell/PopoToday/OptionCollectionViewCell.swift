//
//  OptionCollectionViewCell.swift
//  popo
//
//  Created by 초이 on 2021/10/19.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var borderView: UIView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    // MARK: - Functions
    
    func initUI() {
        borderView.makeRoundedWithBorder(radius: 30, color: UIColor.systemGray2.cgColor)
        contentTextView.textContainerInset = .zero
    }
    
    func initCell(title: String, content: String) {
        titleLabel.text = title
        contentTextView.text = content
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchEditButton(_ sender: UIButton) {
        
    }
}
