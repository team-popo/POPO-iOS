//
//  CalendarViewController.swift
//  popo
//
//  Created by 초이 on 2021/09/30.
//

import UIKit

class CalendarViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var yearMonthLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var calendarBgView: UIView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var bgViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var year: Int = 2021
    var month: Int = 10
    
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let topSpacing = UIScreen.main.bounds.height * 0.2
        
        static let collectionViewSpacing: CGFloat = 22 * 2
        static let cellSpacing: CGFloat = 12
        static let cellWidth = ( screenWidth - collectionViewSpacing - cellSpacing * 4 ) / 5
        static let cellHeight = cellWidth * 1.3
    }
    var trackerData = TrackerData(category: 0, background: "", tracker: [])
    var popoId: Int = 1
    
    // date
    var dateArray: [String] = ["", "", ""]
    
    // photo picker
    var photoPicker = UIImagePickerController()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initView()
        initYearMonthLabel(year: year, month: month)
        assignDelegation()
        registerXib()
        getCurrentFormattedDate()
        
        getTracker(popoId: popoId, year: self.year, month: self.month)
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
    
    private func initYearMonthLabel(year: Int, month: Int) {
        guard let monthName = AppMonth(rawValue: month)?.getFullEnglish() else { return }
        
        yearMonthLabel.text = "\(year)\n\(monthName)"
    }
    
    // assign, register functions
    private func assignDelegation() {
        self.calendarCollectionView.delegate = self
        self.calendarCollectionView.dataSource = self
        photoPicker.delegate = self
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
        photoPicker.sourceType = .photoLibrary
        present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func touchCalendarButton(_ sender: UIBarButtonItem) {
        let changeMonthPopupViewController = ChangeMonthPopupViewController()
        changeMonthPopupViewController.modalTransitionStyle = .crossDissolve
        changeMonthPopupViewController.modalPresentationStyle = .overFullScreen
        
        changeMonthPopupViewController.year = Int(dateArray[0]) ?? 0
        changeMonthPopupViewController.month = Int(dateArray[1]) ?? 0
        changeMonthPopupViewController.calendarModalViewDelegate = self
        
        self.present(changeMonthPopupViewController, animated: true, completion: nil)
    }
    
    func updateData(data: TrackerData) {
        self.trackerData = data
        self.calendarCollectionView.reloadData()
        self.backgroundImageView.updateServerImage(trackerData.background)
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
        
        return trackerData.tracker.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.calendarCollectionViewCell, for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.initCell(tracker: trackerData.tracker[indexPath.row])
        
        return cell
    }
    
}

// MARK: - 통신

extension CalendarViewController {
    
    func getTracker(popoId: Int, year: Int, month: Int) {
        
        TrackerAPI.shared.getPopoList(popoId: popoId, year: year, month: month) { (response) in
            switch response {
            case .success(let trackerData):
                
                if let data = trackerData as? TrackerData {
                    self.updateData(data: data)
                    self.initYearMonthLabel(year: year, month: month)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
        
    }
    
    func patchBackgroundImage(popoId: Int, image: UIImage) {
        
        TrackerAPI.shared.patchBackgroundImage(popoId: popoId, image: image) { (response) in
            switch response {
            case .success(let trackerData):
                // 이미지 업로드 성공
                print("success - patchBackgroundImage")
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
        
    }
    
}

// MARK: - CalendarModalViewDelegate

extension CalendarViewController: CalendarModalViewDelegate {
    func passData(year: Int, month: Int) {
        self.dateArray[0] = "\(year)"
        self.dateArray[1] = "\(month)"
        
        getTracker(popoId: popoId, year: year, month: month)
        
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension CalendarViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    // didFinishPickingMediaWithInfo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            backgroundImageView.image = image
            patchBackgroundImage(popoId: popoId, image: image)
        }
        dismiss(animated: true, completion: nil)
    }
}
