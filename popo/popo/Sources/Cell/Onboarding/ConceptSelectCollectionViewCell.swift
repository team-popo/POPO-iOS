//
//  ConceptSelectCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/25.
//

import UIKit

class ConceptSelectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backImage: UIImageView!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    
    func initBackgroundImage(image: String) {
        backImage.image = UIImage(named: image)
        backImage.sizeToFit()
    }
}
