//
//  OnbardingCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/07/20.
//

import UIKit

class OnboardingCell: UICollectionViewCell {

    // MARK: - Properties
    static let identifier = "OnboardingCell"
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var pageControllerImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        // Initialization code
    }

    // MARK: - Methods
    private func setUI() {
        imageView.contentMode = .scaleAspectFit
        pageControllerImage.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
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
