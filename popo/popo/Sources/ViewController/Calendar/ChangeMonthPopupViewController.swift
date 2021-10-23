//
//  ChangeMonthPopupViewController.swift
//  popo
//
//  Created by 초이 on 2021/10/19.
//

import UIKit

protocol CalendarModalViewDelegate: AnyObject {
    func passData(year: Int, month: Int)
}

class ChangeMonthPopupViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var monthPickerView: UIPickerView!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - Properties
    
    var year: Int = 0
    var month: Int = 0

    var yearArray: [String] = []
    var monthArray: [String] = []
    
    var currentYearMonths: [String] = []
    
    var currentDate = AppDate()
    weak var calendarModalViewDelegate: CalendarModalViewDelegate?
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
        assignDatasource()
        assignDelegate()
        setPickerInitialSetting()
        initViewRounding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.yearPickerView.subviews[1].backgroundColor = UIColor.clear
        self.monthPickerView.subviews[1].backgroundColor = UIColor.clear
        
    }
    
    // MARK: - Functions
    
    private func assignDatasource() {
        self.monthPickerView.dataSource = self
        self.yearPickerView.dataSource = self
    }
    
    private func assignDelegate() {
        self.monthPickerView.delegate = self
        self.yearPickerView.delegate = self
    }
    
    private func initViewRounding() {
        completeButton.makeRounded(radius: completeButton.frame.height / 2)
    }
    
    private func setData() {
        for tempYear in 2020...currentDate.getYear() {
            self.yearArray.append(String(tempYear))
        }
        for tempMonth in 1...12 {
            if tempMonth <= self.currentDate.getMonth() {
                self.currentYearMonths.append(String(tempMonth))
            }
            self.monthArray.append(String(tempMonth))
        }
        
    }
    
    private func setPickerInitialSetting() {
        self.yearPickerView.selectRow(self.year - 2000, inComponent: 0, animated: true)
        self.monthPickerView.selectRow(self.month - 1, inComponent: 0, animated: true)
    }
    
    private func updateMonthDatePickerData(_ unwrappedYear: Int) {
        if unwrappedYear == currentDate.getYear() && self.year != currentDate.getYear() {
            if month > currentDate.getMonth() {
                month = currentDate.getMonth()
            }
            self.year = unwrappedYear
            self.monthPickerView.reloadComponent(0)
        } else if unwrappedYear != currentDate.getYear() && self.year == currentDate.getYear() {
            self.year = unwrappedYear
            self.monthPickerView.reloadComponent(0)
        } else {
            self.year = unwrappedYear
        }
    }
    
    private func dismissToCalnedarViewController() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func touchApplyButton(_ sender: Any) {
        
        if let modal = calendarModalViewDelegate {
            modal.passData(year: self.year, month: self.month)
        }
        
        dismissToCalnedarViewController()
    }
}

extension ChangeMonthPopupViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == self.yearPickerView {
            return NSAttributedString(string: yearArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        } else if year == currentDate.getYear() {
            return NSAttributedString(string: currentYearMonths[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        } else {
            return NSAttributedString(string: monthArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.yearPickerView {
            guard let unwrappedYear = Int(yearArray[row]) else {
                return
            }
            updateMonthDatePickerData(unwrappedYear)
        } else if year == currentDate.getYear() {
            guard let unwrappedMonth = Int(currentYearMonths[row]) else {
                return
            }
            self.month = unwrappedMonth
        } else {
            guard let unwrappedMonth = Int(monthArray[row]) else {
                return
            }
            self.month = unwrappedMonth
        }
    }
}

extension ChangeMonthPopupViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.yearPickerView {
            return yearArray.count
        } else if self.year == currentDate.getYear() {
            return currentYearMonths.count
        } else {
            return monthArray.count
        }
    }
}
