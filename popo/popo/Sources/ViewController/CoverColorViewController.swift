//
//  CoverColorViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/25.
//

import UIKit

class CoverColorViewController: UIViewController {
    
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
        setRandomCover()
//        makeColorArray()
    }

    @IBAction func touchPopo(_ sender: Any) {
        coverImageView12.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        coverImageView11.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        coverImageView10.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        coverImageView9.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        coverImageView8.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        coverImageView7.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        coverImageView6.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        coverImageView5.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        coverImageView4.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        coverImageView3.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        coverImageView2.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        coverImageView1.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
}

extension CoverColorViewController {
    private func setUI() {
        whiteBgView.makeRounded(radius: 30)
    }
    

    
    private func setRandomCover() {
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
    
//    private func makeColorArray() {
//        colorViews.append(String(coverImageView1.backgroundColor))
//        colorViews.append(coverImageView2.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView3.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView4.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView5.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView6.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView7.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView8.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView9.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView10.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView11.backgroundColor?.cgColor!)
//        colorViews.append(coverImageView12.backgroundColor?.cgColor!)
//    }
}
