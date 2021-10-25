//
//  UIImageView+Extension.swift
//  popo
//
//  Created by 초이 on 2021/10/23.
//

import Foundation
import Kingfisher

extension UIImageView {
    @discardableResult
    func updateServerImage(_ imagePath: String) -> Bool {
        guard let url = URL(string: imagePath) else {
            self.image = UIImage(named: "cover_01")!
            return false
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0)),
                .cacheOriginalImage
            ]) { result in
            switch result {
            case .success:
                return
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        return true
    }
}
