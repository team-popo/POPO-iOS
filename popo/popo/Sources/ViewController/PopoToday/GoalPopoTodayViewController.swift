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
    private var imageURL = ""
    
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        static let cellWidth: CGFloat = screenWidth
        static let cellHeight: CGFloat = screenHeight
        
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
        todayCollectionView.register(goalNib, forCellWithReuseIdentifier: Const.Xib.todayImageCollectionViewCell)
        
        let optionNib = UINib(nibName: Const.Xib.optionCollectionViewCell, bundle: nil)
        todayCollectionView.register(optionNib, forCellWithReuseIdentifier: Const.Xib.optionCollectionViewCell)
    }
    
    private func popoTodayFetchWithAPI() {
        // TODO: 서버통신
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
            
            cell.initCell(imageURL, nameList[0], contentList[0], nameList[1], contentList[1])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.optionCollectionViewCell, for: indexPath) as? OptionCollectionViewCell else {
                return UICollectionViewCell()
            }
            // 목표, 달성에 해당하는 0,1 index 제외 고려.
            cell.initCell(title: nameList[indexPath.item + 1], content: contentList[indexPath.item + 1])
            return cell
        }
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
            return CGSize(width: Size.cellWidth, height: Size.cellHeight)
        }
        else {
            // TODO: 동적인 높이 조절
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
        return .zero
    }
}
