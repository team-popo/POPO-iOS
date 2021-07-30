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
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var completeButton: UIButton!
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
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: - @IBAction Methods
    @IBAction func touchPopo(_ sender: Any) {
        coverImageView1.backgroundColor = getRandomColor()
        coverImageView2.backgroundColor = getRandomColor()
        coverImageView3.backgroundColor = getRandomColor()
        coverImageView4.backgroundColor = getRandomColor()
        coverImageView5.backgroundColor = getRandomColor()
        coverImageView6.backgroundColor = getRandomColor()
        coverImageView7.backgroundColor = getRandomColor()
        coverImageView8.backgroundColor = getRandomColor()
        coverImageView9.backgroundColor = getRandomColor()
        coverImageView10.backgroundColor = getRandomColor()
        coverImageView11.backgroundColor = getRandomColor()
        coverImageView12.backgroundColor = getRandomColor()
    }
    
    @IBAction func touchCompleteButton(_ sender: Any) {
        makeColorArray()
    }
}

// MARK: - Extensions
extension CoverColorViewController {
    
    // MARK: - Methods
    private func setUI() {
        whiteBgView.makeRounded(radius: 30)
        
        completeButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4862745098, blue: 0.9333333333, alpha: 1), for: .normal)
        completeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        coverImageView1.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        coverImageView2.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        coverImageView3.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        coverImageView4.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        coverImageView5.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        coverImageView6.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        coverImageView7.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        coverImageView8.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        coverImageView9.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        coverImageView10.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        coverImageView11.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        coverImageView12.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }

    private func getRandomColor() -> UIColor {
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        let randomColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
        return randomColor
    }
    
    private func makeColorArray() {
        var colorList: [String] = []

        if let color1 = coverImageView1.backgroundColor?.toHexString() {
            colorList.append(color1)
        }
        if let color2 = coverImageView2.backgroundColor?.toHexString() {
            colorList.append(color2)
        }
        if let color3 = coverImageView3.backgroundColor?.toHexString() {
            colorList.append(color3)
        }
        if let color4 = coverImageView4.backgroundColor?.toHexString() {
            colorList.append(color4)
        }
        if let color5 = coverImageView5.backgroundColor?.toHexString() {
            colorList.append(color5)
        }
        if let color6 = coverImageView6.backgroundColor?.toHexString() {
            colorList.append(color6)
        }
        if let color7 = coverImageView7.backgroundColor?.toHexString() {
            colorList.append(color7)
        }
        if let color8 = coverImageView8.backgroundColor?.toHexString() {
            colorList.append(color8)
        }
        if let color9 = coverImageView9.backgroundColor?.toHexString() {
            colorList.append(color9)
        }
        if let color10 = coverImageView10.backgroundColor?.toHexString() {
            colorList.append(color10)
        }
        if let color11 = coverImageView11.backgroundColor?.toHexString() {
            colorList.append(color11)
        }
        if let color12 = coverImageView12.backgroundColor?.toHexString() {
            colorList.append(color12)
        }
        colorViewList = colorList
        print(colorViewList)
        
        onboardingCoverColorWithAPI()
    }
    
    private func onboardingCoverColorWithAPI() {
        // 서버통신
    }
}
