//
//  CoverGradientViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/25.
//

import UIKit

class CoverGradientViewController: UIViewController {
    
    // MARK: - Properties
    
    private var completedGradientList = [[String]]()
    private var coverGradientViewList = [UIView]()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var whiteBgView: UIView!
    @IBOutlet weak var coverGradientView1: UIView!
    @IBOutlet weak var coverGradientView2: UIView!
    @IBOutlet weak var coverGradientView3: UIView!
    @IBOutlet weak var coverGradientView4: UIView!
    @IBOutlet weak var coverGradientView5: UIView!
    @IBOutlet weak var coverGradientView6: UIView!
    @IBOutlet weak var coverGradientView7: UIView!
    @IBOutlet weak var coverGradientView8: UIView!
    @IBOutlet weak var coverGradientView9: UIView!
    @IBOutlet weak var coverGradientView10: UIView!
    @IBOutlet weak var coverGradientView11: UIView!
    @IBOutlet weak var coverGradientView12: UIView!
    
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchPopo(_ sender: Any) {
        
        setRandomGradient()
    }
    
    @IBAction func touchCompleteButton(_ sender: Any) {
        completedGradientList = makeGradientArray()
        onboardingCoverGradientWithAPI(coverGradientViewList: completedGradientList)
    }
    
}

extension CoverGradientViewController {
    private func setUI() {
        whiteBgView.makeRounded(radius: 30)
        
        coverGradientViewList = [coverGradientView1, coverGradientView2, coverGradientView3, coverGradientView4, coverGradientView5, coverGradientView6, coverGradientView7, coverGradientView8, coverGradientView9, coverGradientView10, coverGradientView11, coverGradientView12]
        
        _ = coverGradientViewList.map { $0.layer.masksToBounds = true }
        
        setRandomGradient()
        
        completeButton.setTitle("??????", for: .normal)
        completeButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4862745098, blue: 0.9333333333, alpha: 1), for: .normal)
        completeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    private func setRandomGradient() {
        
        // ????????????????????? ????????? ????????? ??? ???????????? ?????? ???????????? ????????? ????????? ???????????? ?????? ????????? ?????????
        // ?????? ?????? ??????
        for index in 0..<coverGradientViewList.count {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = coverGradientViewList[index].bounds
            
            // gradient ??????
            var randomColorList = [CGColor]()
            var gradientLayerList = [CALayer]()
            
            for _ in 1...2 {
                randomColorList.append(setRandomColor())
            }
            gradientLayer.colors = randomColorList
            gradientLayerList.append(gradientLayer)
            coverGradientViewList[index].layer.addSublayer(gradientLayer)
        }
    }
    
    private func setRandomColor() -> CGColor {
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        let randomColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0).cgColor
        
        return randomColor
    }
    
    private func makeGradientArray() -> [[String]] {
        // gradient layer ??? colors ??? ???????????? cgcolor ??? string ?????? ??????
        return [[""]]
    }
    
    private func onboardingCoverGradientWithAPI(coverGradientViewList: [[String]]) {
        // ????????????
    }
}
