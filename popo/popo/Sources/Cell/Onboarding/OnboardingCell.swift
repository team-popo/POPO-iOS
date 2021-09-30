//
//  OnbardingCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/07/20.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var pageControllerImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Cell Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        // Initialization code
    }

    // MARK: - Methods
    
    private func setUI() {
        imageView.contentMode = .scaleAspectFit
        pageControllerImage.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3294117647, blue: 0.8, alpha: 1)
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        subtitleLabel.textColor = #colorLiteral(red: 0.4784313725, green: 0.462745098, blue: 0.462745098, alpha: 1)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textAlignment = .center
    }
    
    func initCell(title: String, subtitle: String, pageImage: String, imageView: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        if let pageImage = UIImage(named: pageImage) {
            self.pageControllerImage.image = pageImage
        }
        if let image = UIImage(named: imageView) {
            self.imageView.image = image
        }
        
    }
}
