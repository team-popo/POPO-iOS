//
//  ConceptViewController.swift
//  popo
//
//  Created by 초이 on 2021/05/26.
//

import UIKit

class ConceptViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var whiteBgView: UIView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initWhiteBgView()
    }
    
    // MARK: - Functions
    
    private func initWhiteBgView() {
        // rounding
        whiteBgView.makeRounded(radius: 30)
        
        // shadow
        whiteBgView.layer.shadowColor = UIColor.black.cgColor
        whiteBgView.layer.shadowOffset = CGSize(width: 0, height: 4)
        whiteBgView.layer.shadowRadius = 4
        whiteBgView.layer.shadowOpacity = 0.25
        whiteBgView.layer.masksToBounds = false
        
        // 그림자를 캐시에 저장해 재사용
        whiteBgView.layer.shouldRasterize = true
    }
    
    // MARK: - @IBAction Functions

}
