//
//  CoverCalendarViewController.swift
//  popo
//
//  Created by 초이 on 2021/05/23.
//

import UIKit

class CoverCalendarViewController: UIViewController {
    
    // MARK: - Properties
    
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
    
    var coverImageViews: [UIImageView] = []
    
    // MARK: - @IBOutlet Properties
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeImageViewArray()
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func makeImageViewArray() {
        coverImageViews.append(coverImageView1)
        coverImageViews.append(coverImageView2)
        coverImageViews.append(coverImageView3)
        coverImageViews.append(coverImageView4)
        coverImageViews.append(coverImageView5)
        coverImageViews.append(coverImageView6)
        coverImageViews.append(coverImageView7)
        coverImageViews.append(coverImageView8)
        coverImageViews.append(coverImageView9)
        coverImageViews.append(coverImageView10)
        coverImageViews.append(coverImageView11)
        coverImageViews.append(coverImageView12)
    }
    
    private func initViewRounding() {
        whiteBgView.makeRounded(radius: 30)
    }
    
    private func pushToConceptViewController() {
        let conceptStoryboard = UIStoryboard(name: Const.Storyboard.Name.concept, bundle: nil)
        guard let conceptViewController = conceptStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.concept) as? ConceptViewController else { return }
        self.navigationController?.pushViewController(conceptViewController, animated: true)
    }
    
    // MARK: - @IBAction Functions

    @IBAction func touchPopo(_ sender: Any) {
        pushToConceptViewController()
    }
}
