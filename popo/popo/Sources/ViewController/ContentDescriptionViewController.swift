//
//  ContentDescriptionViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/24.
//

import UIKit

class ContentDescriptionViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var backgroundImage: UIImageView!
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    @IBAction func pushToConceptSelect(_ sender: Any) {
        print("touch")
        let storyboard = UIStoryboard.init(name: Const.Storyboard.Name.conceptSelect, bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.conseptSelect) as? ConceptSelectViewController else {
            return
        }

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Extenstion Methods
extension ContentDescriptionViewController {
    func setUI() {
        
    }
}
