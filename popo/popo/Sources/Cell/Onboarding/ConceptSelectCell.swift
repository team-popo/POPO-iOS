//
//  ConceptSelectCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/25.
//

import UIKit

class ConceptSelectCell: UICollectionViewCell {
    
    @IBOutlet weak var backImage: UIImageView!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    
    func setBackgroundImage(image: String) {
        backImage.image = UIImage(named: image)
        backImage.sizeToFit()
    }
}
