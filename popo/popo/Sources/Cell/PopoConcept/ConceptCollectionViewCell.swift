//
//  ConceptCollectionViewCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/17.
//

import UIKit
import Kingfisher

class ConceptCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Cell Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initCell(_ url: String) {
        if let url = URL(string: url) {
            imageView.kf.setImage(with: url)
        }
    }
}
