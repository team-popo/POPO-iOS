//
//  CoverGradientViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/25.
//

import UIKit

class CoverGradientViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var whiteBgView: UIView!
    @IBOutlet weak var coverImageView1: UIImageView!
    @IBOutlet weak var coverImageView2: UIImageView!
    @IBOutlet weak var coverImageView3: UIImageView!
    @IBOutlet weak var coverImageView4: UIImageView!
    @IBOutlet weak var coverImageView5: UIImageView!
    @IBOutlet weak var coverImageView6: UIImageView!
    @IBOutlet weak var coverImageView7: UIImageView!
    @IBOutlet weak var coverImageView8: UIImageView!
    @IBOutlet weak var coverImageView9: UIImageView!
    @IBOutlet weak var coverImageView10: UIImageView!
    @IBOutlet weak var coverImageView11: UIImageView!
    @IBOutlet weak var coverImageView12: UIImageView!
    
//    var colorViews: [String] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
//        setRandomCover()
        
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchPopo(_ sender: Any) {
    }
    
}

extension CoverGradientViewController {
    private func setUI() {
        whiteBgView.makeRounded(radius: 30)
    }
    
//    private func makeImageViewArray() {
//        coverImageViews.append(coverImageView1)
//        coverImageViews.append(coverImageView2)
//        coverImageViews.append(coverImageView3)
//        coverImageViews.append(coverImageView4)
//        coverImageViews.append(coverImageView5)
//        coverImageViews.append(coverImageView6)
//        coverImageViews.append(coverImageView7)
//        coverImageViews.append(coverImageView8)
//        coverImageViews.append(coverImageView9)
//        coverImageViews.append(coverImageView10)
//        coverImageViews.append(coverImageView11)
//        coverImageViews.append(coverImageView12)
//    }
    
    private func setRandomCover() {

    }
}
