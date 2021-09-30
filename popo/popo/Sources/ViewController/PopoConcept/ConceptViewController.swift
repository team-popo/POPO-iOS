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
        initWhiteBgView()
        getPopoListWithAPI()
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
