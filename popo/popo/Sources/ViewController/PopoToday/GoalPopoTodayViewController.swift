//
//  PopoTodaySpecificViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/20.
//

import UIKit

class GoalPopoTodayViewController: UIViewController {
    
    // MARK: - Properties
    
    private var nameList = [String]()
    private var contentList = [String]()
    private var typeList = [Int]()
    private var imageURL: String?
    private var goalText: String?
    private var acheivementText: String?
    
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let cellWidth: CGFloat = screenWidth
        static let cellHeight: CGFloat = cellWidth
        
        static let cellLineSpacing: CGFloat = 10
        static let cellInterItemSpacing: CGFloat = 0
    }
    
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
        self.navigationController?.initWithBackButton()
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
    }
    
    private func popoTodayFetchWithAPI() {
        TodayAPI.shared.getTodayFetch(popoID: 2, dayID: 35) { result in
            switch result {
            case .success(let data):
                if let popoToday = data as? PopoToday {
                    self.goalText = popoToday.options[0].contents
                    self.acheivementText = popoToday.options[1].contents
                    
                    for index in 2..<popoToday.options.count {
                        self.nameList.append(popoToday.options[index].name)
                        self.contentList.append(popoToday.options[index].contents)
                        self.typeList.append(popoToday.options[index].type)
                    }
                    self.imageURL = popoToday.image
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

// MARK: - UICollectionViewDelegate

extension GoalPopoTodayViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension GoalPopoTodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.todayGoalImageCollectionViewCell, for: indexPath) as? TodayGoalImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.initCell(imageURL ?? "", goalText ?? "", acheivementText ?? "")
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
                cell.initCell(title: nameList[indexPath.item - 1], content: contentList[indexPath.item - 1])
                
                return cell
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GoalPopoTodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellLineSpacing - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: Size.cellWidth, height: Size.cellHeight)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
}
