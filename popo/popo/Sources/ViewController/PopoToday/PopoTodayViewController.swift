//
//  PopoTodayViewController.swift
//  popo
//
//  Created by 초이 on 2021/10/19.
//

import UIKit

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
    
    var dummyStrings = [
        "ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ", "미나리는 어디서든 잘 자라 낯선 미국, 아칸소로 떠나온 한국 가족. 가족들에게 뭔가 해내는 걸 보여주고 싶은 아빠 '제이콥'(스티븐 연)", "오늘 물이 도착하지 않아 목표만큼 마시지 못했다. 내일 아침 물이 배달되면 제대로 마셔야겠다. 미리미리 사둘걸 ㅠㅠ", "오늘 물이 도착하지 않아 목표만큼 마시지 못했다. 내일 아침 물이 배달되면 제대로 마셔야겠다. 미리미리 사둘걸 ㅠㅠ오늘 물이 도착하지 않아 목표만큼 마시지 못했다. 내일 아침 물이 배달되면 제대로 마셔야겠다. 미리미리 사둘걸 ㅠㅠ오늘 물이 도착하지 않아 목표만큼 마시지 못했다. 내일 아침 물이 배달되면 제대로 마셔야겠다. 미리미리 사둘걸 ㅠㅠ오늘 물이 도착하지 않아 목표만큼 마시지 못했다. 내일 아침 물이 배달되면 제대로 마셔야겠다. 미리미리 사둘걸 ㅠㅠ오늘 물이 도착하지 않아 목표만큼 마시지 못했다. 내일 아침 물이 배달되면 제대로 마셔야겠다. 미리미리 사둘걸 ㅠㅠ222aㅁㅁㅁ"
    ]
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        assignDelegation()
        registerXib()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func assignDelegation() {
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
    }
    
    private func registerXib() {
        todayCollectionView.register(UINib(nibName: Const.Xib.todayImageCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.todayImageCollectionViewCell)
        todayCollectionView.register(UINib(nibName: Const.Xib.optionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.optionCollectionViewCell)
    }
    
    // MARK: - @IBAction Functions

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
        }
        
        let itemSize = NSString(string: dummyStrings[indexPath.row - 1]).boundingRect(
            with: CGSize(width: Size.screenWidth - 50, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ],
            context: nil)
        
        return CGSize(width: Size.cellWidth, height: itemSize.height + 80)
    }
}

// MARK: - UICollectionViewDataSource

extension PopoTodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 서버 통신 후 수정
        return dummyStrings.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.todayImageCollectionViewCell, for: indexPath) as? TodayImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.optionCollectionViewCell, for: indexPath) as? OptionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.initCell(title: "제목", content: dummyStrings[indexPath.row - 1])
        
        return cell
    }
    
}
