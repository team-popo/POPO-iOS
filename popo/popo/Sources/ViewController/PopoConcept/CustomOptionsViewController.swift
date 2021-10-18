//
//  CustomOptionsViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/16.
//

import UIKit

class CustomOptionsViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var optionTextField: UITextField!
    @IBOutlet weak var textOptionCheckButton: UIButton!
    @IBOutlet weak var starOptionCheckButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        textFieldDelegate()
        initGesture()
    }

    // MARK: - @IBAction Properties
    
    @IBAction func dismissToOptionsViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil )
    }
    @IBAction func touchCompleteButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil )
    }
}

// MARK: - Extensions

extension CustomOptionsViewController {
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        bgView.makeRounded(radius: 20)
        
        completeButton.makeRounded(radius: 20)
        
        textOptionCheckButton.setImage(UIImage(systemName: "square"), for: .normal)
        textOptionCheckButton.tintColor = UIColor(named: "popoPurple")
        textOptionCheckButton.setTitle("", for: .normal)
        
        starOptionCheckButton.setImage(UIImage(systemName: "square"), for: .normal)
        starOptionCheckButton.tintColor = UIColor(named: "popoPurple")
        starOptionCheckButton.setTitle("", for: .normal)
        
        closeButton.setTitle("", for: .normal)
    }
    
    private func textFieldDelegate() {
        optionTextField.delegate = self
    }
    
    private func initGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
}

// MARK: - CustomOptionsViewController

extension CustomOptionsViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        <#code#>
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
