//
//  PopoTodaySpecificViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/20.
//

import UIKit

class GoalPopoTodayViewController: UIViewController {
    
    // MARK: - Properties
    
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let cellWidth: CGFloat = screenWidth
        static let cellHeight: CGFloat = cellWidth
        static let imageCellHeight: CGFloat = screenWidth - 50
        static let cellLineSpacing: CGFloat = 10
        static let cellInterItemSpacing: CGFloat = 0
    }
    
    // for today popo fetch
    private var nameList = [String]()
    private var contentList = [String]()
    private var typeList = [Int]()
    private var imageURL: String?
    private var todayDate: String?
    private var goalText: String?
    private var acheivementText: String?
    private var goalContentsID: Int?
    private var acheivementContentsID: Int?
    var dayID: Int?
    var category: Int?
    
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
    
    // from get popo
    var optionData: [Option] = [Option(id: 0, name: "", contents: "", type: 0, order: 0)]
    
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
    var editingImage: UIImage = UIImage()
    var isEditingMode: Bool = false
    
    weak var reloadCalendarProtocol: ReloadCalendarProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        assignDelegate()
        registerXib()
        popoTodayFetchWithAPI()
    }
}

// MARK: - Extensions

extension GoalPopoTodayViewController {
    private func initNavigationBar() {
        if isEditingMode {
            self.navigationController?.initWithBackAndDoneButton(navigationItem: self.navigationItem, doneButtonClosure: #selector(touchDoneButton(_:)))
        } else {
            self.navigationController?.initWithBackButton()
        }
    }
    
    private func assignDelegate() {
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
    }
    
    private func registerXib() {
        let goalNib = UINib(nibName: Const.Xib.todayGoalImageCollectionViewCell, bundle: nil)
        todayCollectionView.register(goalNib, forCellWithReuseIdentifier: Const.Xib.todayGoalImageCollectionViewCell)
        
        let optionNib = UINib(nibName: Const.Xib.optionCollectionViewCell, bundle: nil)
        todayCollectionView.register(optionNib, forCellWithReuseIdentifier: Const.Xib.optionCollectionViewCell)
        
        let starNib = UINib(nibName: Const.Xib.starOptionCollectionViewCell, bundle: nil)
        todayCollectionView.register(starNib, forCellWithReuseIdentifier: Const.Xib.starOptionCollectionViewCell)
    }
    
    private func makeGoalRatioImage(category: Int, acheivementContent: Float, goalContent: Float) -> UIImage {
        if category == 6 {
            let goalRatio: Float = (acheivementContent / goalContent) * 100
            var goalRatioImage = UIImage()
            switch goalRatio {
            case 0.0..<25.0:
                goalRatioImage = UIImage(named: "water0")!
                return goalRatioImage
            case 25.0..<50.0:
                goalRatioImage = UIImage(named: "water25")!
                return goalRatioImage
            case 50.0..<75.0:
                goalRatioImage = UIImage(named: "water50")!
                return goalRatioImage
            case 75.0..<100.0:
                goalRatioImage = UIImage(named: "water75")!
                return goalRatioImage
            default:
                goalRatioImage = UIImage(named: "water100")!
                return goalRatioImage
            }
        } else {
            let goalRatio: Float = (acheivementContent / goalContent) * 100
            var goalRatioImage = UIImage()
            switch goalRatio {
            case 0.0..<25.0:
                goalRatioImage = UIImage(named: "pie0")!
                return goalRatioImage
            case 25.0..<50.0:
                goalRatioImage = UIImage(named: "pie25")!
                return goalRatioImage
            case 50.0..<75.0:
                goalRatioImage = UIImage(named: "pie50")!
                return goalRatioImage
            case 75.0..<100.0:
                goalRatioImage = UIImage(named: "pie75")!
                return goalRatioImage
            default:
                goalRatioImage = UIImage(named: "pie100")!
                return goalRatioImage
            }
        }
    }
    
    // MARK: - 통신
    
    func postNewPopo(popoId: Int, contents: NewPopo, image: UIImage) {
    
        TodayAPI.shared.postNewPopo(popoId: popoId, contents: contents, image: image) { (response) in
            switch response {
            case .success(_):
                // delegate로 calendar view reload
                self.reloadCalendarProtocol?.reloadCalendar()
                // 완료되면 pop
                self.navigationController?.popViewController(animated: true)
            case .requestErr(let message):
                print("postNewPopo - requestErr", message)
            case .pathErr:
                print("postNewPopo - .pathErr")
            case .serverErr:
                print("postNewPopo - serverErr")
            case .networkFail:
                print("postNewPopo - networkFail")
            }
        }
    }
    
    private func popoTodayFetchWithAPI() {
        if !isEditingMode {
            TodayAPI.shared.getTodayFetch(popoID: popoId, dayID: dayID ?? 0) { result in
                switch result {
                case .success(let data):
                    if let popoToday = data as? PopoToday {
                        self.goalText = popoToday.options[0].contents
                        self.acheivementText = popoToday.options[1].contents
                        self.goalContentsID = popoToday.options[0].id
                        self.acheivementContentsID = popoToday.options[1].id
                        
                        for index in 2..<popoToday.options.count {
                            self.nameList.append(popoToday.options[index].name)
                            self.contentList.append(popoToday.options[index].contents)
                            self.typeList.append(popoToday.options[index].type)
                        }
                        
                        self.optionData = popoToday.options
                        self.imageURL = popoToday.image
                        self.todayDate = popoToday.date
                        self.todayCollectionView.reloadData()
                    }
                case .requestErr(let message):
                    print("popoTodayFetchWithAPI - requestErr: \(message)")
                case .pathErr:
                    print("popoTodayFetchWithAPI - pathErr")
                case .serverErr:
                    print("popoTodayFetchWithAPI - serverErr")
                case .networkFail:
                    print("popoTodayFetchWithAPI - networkFail")
                }
            }
        }
    }
    
    @objc func touchDoneButton(_ sender: UIBarButtonItem) {
        var newPopoOptions = [NewPopoOption]()
        var goalContent: Float = 0.0
        var acheivementContent: Float = 0.0
        for optionIdx in 0..<options.count {
            let newOption = NewPopoOption(optionId: options[optionIdx].id, contents: contents[optionIdx])
            newPopoOptions.append(newOption)
            if optionIdx == 0 {
                goalContent = Float(newPopoOptions[optionIdx].contents) ?? 0
            } else if optionIdx == 1 {
                acheivementContent = Float(newPopoOptions[optionIdx].contents) ?? 0
            }
        }
        let newPopo = NewPopo(id: popoId, date: date.getFormattedDate(with: "-"), options: newPopoOptions)
        let goalRatioImage = makeGoalRatioImage(category: category ?? 0, acheivementContent: acheivementContent, goalContent: goalContent)
        // 통신
        postNewPopo(popoId: popoId, contents: newPopo, image: goalRatioImage)
    }
}

// MARK: - UICollectionViewDelegate

extension GoalPopoTodayViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension GoalPopoTodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEditingMode {
            return options.count - 1
        } else {
            return nameList.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.todayGoalImageCollectionViewCell, for: indexPath) as? TodayGoalImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            if isEditingMode {
                cell.initCell(editingImage, self.dateArray)
                cell.initEditingStatus(isEditing: isEditingMode)
                cell.goalContentTextView.delegate = self
                cell.acheivementContentTextView.delegate = self
                cell.goalContentTextView.tag = 0
                cell.acheivementContentTextView.tag = 1
                cell.category = category
            } else {
                cell.initCell(imageURL ?? "", goalText ?? "", acheivementText ?? "", todayDate ?? "")
                cell.initEditingStatus(isEditing: isEditingMode)
                cell.setData(popoId: popoId, dayId: dayID ?? 0, category: category ?? 0, goalContentsID: goalContentsID ?? 0, acheivementContentsID: acheivementContentsID ?? 0)
            }
            // TODO: CONNET
//            cell.reloadCalendarProtocol = self
            return cell
        } else {
            if isEditingMode {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.optionCollectionViewCell, for: indexPath) as? OptionCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.initCell(options[indexPath.row + 1].name, dummyStrings[indexPath.item - 1])
                cell.initEditingStatus(isEditing: isEditingMode)
                cell.contentTextView.delegate = self
                cell.contentTextView.tag = indexPath.item + 1
                
                return cell
            } else {
                if typeList[indexPath.item - 1] == 1 {
                    // star option
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.starOptionCollectionViewCell, for: indexPath) as? StarOptionCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.initCell(title: nameList[indexPath.item - 1], content: contentList[indexPath.item - 1])
                    
                    return cell
                } else {
                    // text option
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.optionCollectionViewCell, for: indexPath) as? OptionCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.initEditingStatus(isEditing: isEditingMode)
                    cell.initCell(nameList[indexPath.item - 1], contentList[indexPath.item - 1])
                    cell.setData(popoId: popoId, dayId: indexPath.item + 1, contentsId: optionData[indexPath.item + 1].id)
                    
                    return cell
                }
            }
        }
    }
}

// MARK: - UITextViewDelegate

extension GoalPopoTodayViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text ?? ""
        let row = textView.tag
        self.contents[row] = text
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GoalPopoTodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
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
                let optionSize = NSString(string: contentList[indexPath.row - 1]).boundingRect(
                    with: CGSize(width: Size.screenWidth - 50, height: CGFloat.greatestFiniteMagnitude),
                    options: .usesLineFragmentOrigin,
                    attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
                    ],
                    context: nil)
                
                return CGSize(width: Size.cellWidth, height: optionSize.height + 80)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
}
