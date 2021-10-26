//
//  PopoTodayViewController.swift
//  popo
//
//  Created by 초이 on 2021/10/19.
//

import UIKit

protocol ReloadCalendarProtocol: AnyObject {
    func reloadCalendar()
}

class PopoTodayViewController: UIViewController {
    
    // MARK: - Properties
    
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let topSpacing = UIScreen.main.bounds.height * 0.2
        
        static let collectionViewSpacing: CGFloat = 22 * 2
        static let cellSpacing: CGFloat = 12
        static let cellWidth: CGFloat = screenWidth
        static let imageCellHeight: CGFloat = screenWidth + 50
    }
    
    // for today popo fetch
    private var nameList = [String]()
    private var contentList = [String]()
    private var typeList = [Int]()
    private var imageURL: String?
    private var todayDate: String?
    var dayID: Int?
    
    var dummyStrings = [
        "", "", "", "", "", ""
    ]
    
    // date
    var dateArray: [String] = ["", "", "", ""] {
        didSet {
            date = AppDate(year: Int(dateArray[0])!, month: Int(dateArray[1])!, day: Int(dateArray[2])!)
            dateArray[3] = date.getWeekday().toKorean()
        }
    }
    var date = AppDate()
    // options
    var options: [TrackerOptions] = [] {
        didSet {
            contents = Array(repeating: "", count: options.count)
        }
    }
    // contents of each cell's contentTextView
    var contents = [String]()
    // popo id
    var popoId: Int = 0
    
    var isEditingMode: Bool = false
    var editingImage: UIImage = UIImage(named: "emptyImage")!
    var imagePicker = UIImagePickerController()
    
    weak var reloadCalendarProtocol: ReloadCalendarProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        assignDelegation()
        registerXib()
        popoTodayFetchWithAPI(isEditingMode: isEditingMode)
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        
        if isEditingMode {
            self.navigationController?.initWithBackAndDoneButton(navigationItem: self.navigationItem, doneButtonClosure: #selector(touchDoneButton(_:)))
        } else {
            self.navigationController?.initWithBackButton()
        }
    }
    
    private func assignDelegation() {
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        imagePicker.delegate = self
    }
    
    private func registerXib() {
        todayCollectionView.register(UINib(nibName: Const.Xib.todayImageCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.todayImageCollectionViewCell)
        todayCollectionView.register(UINib(nibName: Const.Xib.optionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.optionCollectionViewCell)
        todayCollectionView.register(UINib(nibName: Const.Xib.starOptionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.starOptionCollectionViewCell)
    }
    
    // MARK: - @IBAction Functions
    
    @objc func touchDoneButton(_ sender: UIBarButtonItem) {
        // 통신 할 데이터 만들기
        var newPopoOptions = [NewPopoOption]()
        
        for optionIdx in 0..<options.count {
            let newOption = NewPopoOption(optionId: options[optionIdx].id, contents: contents[optionIdx])
            newPopoOptions.append(newOption)
        }
        
        let newPopo = NewPopo(id: popoId, date: date.getFormattedDate(with: "-"), options: newPopoOptions)
        
        // 통신
        postNewPopo(popoId: popoId, contents: newPopo, image: editingImage)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PopoTodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: Size.cellWidth, height: Size.imageCellHeight)
        } else {
            if isEditingMode {
                let itemSize = NSString(string: dummyStrings[indexPath.row - 1]).boundingRect(
                    with: CGSize(width: Size.screenWidth - 50, height: CGFloat.greatestFiniteMagnitude),
                    options: .usesLineFragmentOrigin,
                    attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
                    ],
                    context: nil)
                
                return CGSize(width: Size.cellWidth, height: itemSize.height + 110)
            } else {
                let itemSize = NSString(string: contentList[indexPath.row - 1]).boundingRect(
                    with: CGSize(width: Size.screenWidth - 50, height: CGFloat.greatestFiniteMagnitude),
                    options: .usesLineFragmentOrigin,
                    attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
                    ],
                    context: nil)
                
                return CGSize(width: Size.cellWidth, height: itemSize.height + 80)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PopoTodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEditingMode {
            return options.count + 1
        } else {
            return nameList.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.todayImageCollectionViewCell, for: indexPath) as? TodayImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if isEditingMode {
                cell.initCell(image: editingImage, dateArray: self.dateArray)
                cell.popoTodayImageUploadProtocol = self
            } else {
                // 서버 통신 후 이미지 수정
                cell.initCell(imageURL: imageURL ?? "", todayDate: todayDate ?? "")
            }
            
            return cell
        } else {
            if isEditingMode {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.optionCollectionViewCell, for: indexPath) as? OptionCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.initCell(title: options[indexPath.row - 1].name, content: dummyStrings[indexPath.row - 1])
                cell.initEditingStatus(isEditing: isEditingMode)
                cell.contentTextView.delegate = self
                cell.contentTextView.tag = indexPath.item
                
                return cell
                
            } else {
                if typeList[indexPath.item - 1] == 1 {
                    // star option
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.starOptionCollectionViewCell, for: indexPath) as? StarOptionCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.initEditingStatus(isEditing: isEditingMode)
                    cell.initCell(title: nameList[indexPath.item - 1], content: contentList[indexPath.item - 1])
                    
                    return cell
                } else {
                    // text option
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.optionCollectionViewCell, for: indexPath) as? OptionCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.initEditingStatus(isEditing: isEditingMode)
                    cell.initCell(title: nameList[indexPath.item - 1], content: contentList[indexPath.item - 1])
                    
                    return cell
                }
            }
        }
    }
}

// MARK: - PopoTodayImageUploadProtocol

extension PopoTodayViewController: PopoTodayImageUploadProtocol {
    
    func uploadImage(_ sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension PopoTodayViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // didFinishPickingMediaWithInfo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.editingImage = image
            self.todayCollectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate

extension PopoTodayViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text ?? ""
        let row = textView.tag - 1
        self.contents[row] = text
    }
}

// MARK: - 통신

extension PopoTodayViewController {
    
    func postNewPopo(popoId: Int, contents: NewPopo, image: UIImage) {
    
        TodayAPI.shared.postNewPopo(popoId: popoId, contents: contents, image: image) { (response) in
            switch response {
            case .success(let data):
                // delegate로 calendar view reload
                self.reloadCalendarProtocol?.reloadCalendar()
                // 완료되면 pop
                self.navigationController?.popViewController(animated: true)
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
    
    private func popoTodayFetchWithAPI(isEditingMode: Bool) {
        if !isEditingMode {
//            TodayAPI.shared.getTodayFetch(popoID: popoId, dayID: dayID ?? 0) { result in
            TodayAPI.shared.getTodayFetch(popoID: popoId, dayID: dayID ?? 0) { result in
                switch result {
                case .success(let data):
                    if let popoToday = data as? PopoToday {
                        for option in popoToday.options {
                            self.nameList.append(option.name)
                            self.contentList.append(option.contents)
                            self.typeList.append(option.type)
                        }
                        self.imageURL = popoToday.image
                        self.todayDate = popoToday.date
                        self.todayCollectionView.reloadData()
                    }
                case .requestErr(let message):
                    print("getPopoListWithAPI - requestErr: \(message)")
                case .pathErr:
                    print("getPopoListWithAPI - pathErr")
                case .serverErr:
                    print("getPopoListWithAPI - serverErr")
                case .networkFail:
                    print("getPopoListWithAPI - networkFail")
                }
            }
        }
    }
    
}
