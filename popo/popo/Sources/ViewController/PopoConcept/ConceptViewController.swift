//
//  ConceptViewController.swift
//  popo
//
//  Created by 초이 on 2021/05/26.
//

import UIKit

class ConceptViewController: UIViewController {
    
    // MARK: - Properties
    
    var conceptImageViews = [UIImageView]()
    var devidedImages = [CGImage]()
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var whiteBgView: UIView!
    
    @IBOutlet weak var conceptImageView1: UIImageView!
    @IBOutlet weak var conceptImageView2: UIImageView!
    @IBOutlet weak var conceptImageView3: UIImageView!
    @IBOutlet weak var conceptImageView4: UIImageView!
    @IBOutlet weak var conceptImageView5: UIImageView!
    @IBOutlet weak var conceptImageView6: UIImageView!
    @IBOutlet weak var conceptImageView7: UIImageView!
    @IBOutlet weak var conceptImageView8: UIImageView!
    @IBOutlet weak var conceptImageView9: UIImageView!
    @IBOutlet weak var conceptImageView10: UIImageView!
    @IBOutlet weak var conceptImageView11: UIImageView!
    @IBOutlet weak var conceptImageView12: UIImageView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initWhiteBgView()
        makeImageViewArray()
        getPopoListWithAPI()
    }
    
    override func viewDidLayoutSubviews() {
        initCoverImage(images: devidedImages)
    }
    
    // MARK: - Functions
    
    private func initWhiteBgView() {
        whiteBgView.makeRounded(radius: 30)
        whiteBgView.makeShadow(color: UIColor.black,
                               offset: CGSize(width: 0, height: 4),
                               radius: 4,
                               opacity: 0.25)
        
        // 그림자를 캐시에 저장해 재사용
        whiteBgView.layer.shouldRasterize = true
    }
    
    private func makeImageViewArray() {
        conceptImageViews.append(conceptImageView1)
        conceptImageViews.append(conceptImageView2)
        conceptImageViews.append(conceptImageView3)
        conceptImageViews.append(conceptImageView4)
        conceptImageViews.append(conceptImageView5)
        conceptImageViews.append(conceptImageView6)
        conceptImageViews.append(conceptImageView7)
        conceptImageViews.append(conceptImageView8)
        conceptImageViews.append(conceptImageView9)
        conceptImageViews.append(conceptImageView10)
        conceptImageViews.append(conceptImageView11)
        conceptImageViews.append(conceptImageView12)
    }
    
    func initCoverImage(images: [CGImage]) {
        
        if images.count == 12 {
            for (idx, image) in images.enumerated() {
                conceptImageViews[idx].image = UIImage(cgImage: image)
            }
        } else {
            print("error")
        }
        
    }
    
    // MARK: - @IBAction Functions

}

// MARK: - Extensions

extension ConceptViewController {
    // 서버통신
    func getPopoListWithAPI() {
        FetchPopoListAPI.shared.getPopoList { result in
            print(result)
        }
    }
}
