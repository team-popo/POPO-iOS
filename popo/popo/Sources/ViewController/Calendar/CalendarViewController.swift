//
//  CalendarViewController.swift
//  popo
//
//  Created by 초이 on 2021/09/30.
//

import UIKit

class CalendarViewController: UIViewController {
    
    // dummy data
    var data = Calendar(category: 0, tracker: [
        Tracker(id: -1, date: 1, image: ""),
        Tracker(id: 0, date: 2, image: "https://miro.medium.com/max/531/0*ODOq4YoezGa42saH.jpg"),
        Tracker(id: -1, date: 3, image: ""),
        Tracker(id: 0, date: 4, image: "https://i.imgur.com/8orhXgvb.jpg"),
        Tracker(id: 0, date: 5, image: "https://i.imgur.com/emWIrPZb.jpg"),
        Tracker(id: 0, date: 6, image: "https://i.imgur.com/6EJI7b.jpg"),
        Tracker(id: 0, date: 7, image: "https://i.imgur.com/LF5Y90yb.jpg"),
        Tracker(id: 0, date: 8, image: "https://i.imgur.com/rdSGowpb.jpg"),
        Tracker(id: 0, date: 9, image: "https://i.imgur.com/zMd4EZ4b.jpg"),
        Tracker(id: 0, date: 10, image: "https://i.imgur.com/ITwKqOWb.jpg"),
        Tracker(id: 0, date: 11, image: "https://i.imgur.com/FYxuRyQb.jpg"),
        Tracker(id: 0, date: 12, image: "https://i.imgur.com/RMlBYTab.jpg"),
        Tracker(id: 0, date: 13, image: "https://i.imgur.com/lJbhoXRb.jpg"),
        Tracker(id: 0, date: 14, image: "https://i.imgur.com/1gk0bavb.jpg"),
        Tracker(id: 0, date: 15, image: "https://i.imgur.com/1cQaAgCb.jpg"),
        Tracker(id: 0, date: 16, image: "https://i.imgur.com/p4UOAkrb.jpg"),
        Tracker(id: 0, date: 17, image: "https://i.imgur.com/VnbOWZZb.jpg"),
        Tracker(id: 0, date: 18, image: "https://i.imgur.com/ypCOswFb.jpg"),
        Tracker(id: 0, date: 19, image: "https://i.imgur.com/8Dud2uIb.jpg"),
        Tracker(id: 0, date: 20, image: "https://i.imgur.com/m2JAoDqb.jpg"),
        Tracker(id: 0, date: 21, image: "https://i.imgur.com/1vHhn6sb.jpg"),
        Tracker(id: -1, date: 22, image: ""),
        Tracker(id: 0, date: 23, image: "https://i.imgur.com/ufHTxWVb.jpg"),
        Tracker(id: 0, date: 24, image: "https://i.imgur.com/g3ynoCOb.jpg"),
        Tracker(id: 0, date: 25, image: "https://i.imgur.com/eTeppWOb.jpg"),
        Tracker(id: -1, date: 26, image: ""),
        Tracker(id: 0, date: 27, image: "https://i.imgur.com/ahcnBy5b.jpg"),
        Tracker(id: -1, date: 28, image: ""),
        Tracker(id: 0, date: 29, image: "https://i.imgur.com/fvJXuvj.jpg"),
        Tracker(id: 0, date: 30, image: "https://i.imgur.com/M1MHdezb.jpg"),
        Tracker(id: 0, date: 31, image: "https://i.imgur.com/HNWMaIvb.jpg")
    ])
    
    // date
    var dateArray: [String] = ["", "", ""]
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var yearMonthLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var calendarBgView: UIView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var bgViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var year: Int = 2021
    var month: Int = 12
    
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let topSpacing = UIScreen.main.bounds.height * 0.2
        
        static let collectionViewSpacing: CGFloat = 22 * 2
        static let cellSpacing: CGFloat = 12
        static let cellWidth = ( screenWidth - collectionViewSpacing - cellSpacing * 4 ) / 5
        static let cellHeight = cellWidth * 1.3
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initView()
        initYearMonthLabel()
        assignDelegation()
        registerXib()
        getCurrentFormattedDate()
    }
    
    // MARK: - Functions
    
    // init functions
    private func initNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.initWithTwoCustomButtons(
            navigationItem: self.navigationItem,
            firstButtonImage: UIImage(systemName: "photo.on.rectangle.angled")!,
            secondButtonImage: UIImage(systemName: "calendar")!,
            firstButtonClosure: #selector(touchChangeBackgroundButton(_:)),
            secondButtonClosure: #selector(touchCalendarButton(_:)))
    }
    
    private func initView() {
        calendarBgView.makeRounded(radius: 30)
        bgViewTopConstraint.constant = Size.topSpacing
    }
    
    private func initYearMonthLabel() {
        guard let monthName = AppMonth(rawValue: month)?.getFullEnglish() else { return }
        
        yearMonthLabel.text = "\(self.year)\n\(monthName)"
    }
    
    // assign, register functions
    private func assignDelegation() {
        self.calendarCollectionView.delegate = self
        self.calendarCollectionView.dataSource = self
    }
    
    private func registerXib() {
        calendarCollectionView.register(UINib(nibName: Const.Xib.calendarCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.calendarCollectionViewCell)
    }
    
    func getCurrentFormattedDate() {
        let today = AppDate()
        let year = today.getYearToString()
        let month = today.getMonthToString()
        let day = today.getDayToString()
        let weekDay = today.getWeekday().toKorean()
        
        dateArray[0] = year
        dateArray[1] = month
        dateArray[2] = day
    }
    
    // @objc functions
    @objc func touchChangeBackgroundButton(_ sender: UIBarButtonItem) {
        // TODO: - 갤러리 열기
    }
    
    @objc func touchCalendarButton(_ sender: UIBarButtonItem) {
        let changeMonthPopupViewController = ChangeMonthPopupViewController()
        changeMonthPopupViewController.modalTransitionStyle = .crossDissolve
        changeMonthPopupViewController.modalPresentationStyle = .overFullScreen
        
        changeMonthPopupViewController.year = Int(dateArray[0]) ?? 0
        changeMonthPopupViewController.month = Int(dateArray[1]) ?? 0
        
        self.present(changeMonthPopupViewController, animated: true, completion: nil)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Size.cellWidth, height: Size.cellHeight)
    }
}

// MARK: - UICollectionViewDataSource

extension CalendarViewController: UICollectionViewDataSource {
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let dayCount = AppMonth(rawValue: month)?.getDayCount() else { return 30 }
        
        return dayCount
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.calendarCollectionViewCell, for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.initCell(tracker: data.tracker[indexPath.row])
        
        return cell
    }
    
}
