//
//  ChangeMonthPopupViewController.swift
//  popo
//
//  Created by 초이 on 2021/10/19.
//

import UIKit

class ChangeMonthPopupViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var monthPickerView: UIPickerView!
    
    // MARK: - Properties
    
    var year: Int = 0
    var month: Int = 0

    var yearArray: [String] = []
    var monthArray: [String] = []
    
    var currentYearMonths: [String] = []
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
