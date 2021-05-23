//
//  LoginMethodViewController.swift
//  popo
//
//  Created by 초이 on 2021/05/20.
//

import UIKit

class LoginMethodViewController: UIViewController {
    // MARK: - Properties
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initButton()
    }
    // MARK: - Functions
    private func initButton() {
        kakaoLoginButton.makeRounded(radius: kakaoLoginButton.frame.height / 2)
        appleLoginButton.makeRounded(radius: appleLoginButton.frame.height / 2)
        emailLoginButton.makeRounded(radius: emailLoginButton.frame.height / 2)
    }
    // MARK: - @IBAction Functions
    @IBAction func touchKakaoLoginButton(_ sender: Any) {
    }
    @IBAction func touchAppleLoginButton(_ sender: Any) {
    }
    @IBAction func touchEmailLoginButton(_ sender: Any) {
    }
}
