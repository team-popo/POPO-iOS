//
//  CoverColorViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/25.
//

import UIKit

class CoverColorViewController: UIViewController {
    
    // MARK: - Propertiesc
    
    private var colorViewList = [String]()
    private var coverColorViewList = [UIView]()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var coverColorView1: UIView!
    @IBOutlet weak var coverColorView2: UIView!
    @IBOutlet weak var coverColorView3: UIView!
    @IBOutlet weak var coverColorView4: UIView!
    @IBOutlet weak var coverColorView5: UIView!
    @IBOutlet weak var coverColorView6: UIView!
    @IBOutlet weak var coverColorView7: UIView!
    @IBOutlet weak var coverColorView8: UIView!
    @IBOutlet weak var coverColorView9: UIView!
    @IBOutlet weak var coverColorView10: UIView!
    @IBOutlet weak var coverColorView11: UIView!
    @IBOutlet weak var coverColorView12: UIView!
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var whiteBgView: UIView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: - @IBAction Methods
    
    @IBAction func touchPopo(_ sender: Any) {
        var _ = coverColorViewList.map { $0.backgroundColor = setRandomColor() }
    }
    
    @IBAction func touchCompleteButton(_ sender: Any) {
        colorViewList = makeColorArray()
        onboardingCoverColorWithAPI(clorViewList: colorViewList)
    }
}

// MARK: - Extensions

extension CoverColorViewController {
    
    // MARK: - Methods
    
    private func setUI() {
        whiteBgView.makeRounded(radius: 30)
        
        completeButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4862745098, blue: 0.9333333333, alpha: 1), for: .normal)
        completeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        coverColorViewList = [coverColorView1, coverColorView2, coverColorView3, coverColorView4, coverColorView5, coverColorView6, coverColorView7, coverColorView8, coverColorView9, coverColorView10, coverColorView11, coverColorView12]
    }

    private func setRandomColor() -> UIColor {
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        let randomColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
        return randomColor
    }
    
    private func makeColorArray() -> [String] {
        let colorList = coverColorViewList.map { $0.backgroundColor!.toHexString() }

        return colorList
    }
    
    private func onboardingCoverColorWithAPI(clorViewList: [String]) {
        // 서버통신
    }
}
