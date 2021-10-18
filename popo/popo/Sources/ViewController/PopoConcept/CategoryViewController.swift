//
//  CategoryViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/21.
//

import UIKit

class CategoryViewController: UIViewController {

    // MARK: - Properties
    
    var categoryList = [String]()
    var imageList = [String]()
    var id: Int?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        initCategoryList()
        registerCell()
    }
}

// MARK: - Extensions

extension CategoryViewController {
    private func setUI() {
        categoryCollectionView.backgroundColor = .clear
    }
    
    private func initCategoryList() {
        categoryList.append(contentsOf: ["영화",
                                         "책",
                                         "음식",
                                         "음악",
                                         "공부",
                                         "물",
                                         "운동",
                                         "기타"])
        imageList.append(contentsOf: ["movieCategoryImg",
                                      "bookCategoryImg",
                                      "foodCategoryImg",
                                      "musicCategoryImg",
                                      "studyCategoryImg",
                                      "waterCategoryImg",
                                      "fitnessCategoryImg",
                                      "etcCategoryImg"])
    }
    
    private func registerCell() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        let cateogoryCell = UINib(nibName: Const.Xib.categoryCell, bundle: nil)
        categoryCollectionView.register(cateogoryCell, forCellWithReuseIdentifier: Const.Xib.categoryCell)
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Const.Storyboard.Name.options, bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.options) as? OptionsViewController else {
            return
        }
        if indexPath.item == 0 {
            nextVC.recommendationOptionsList = [
                OptionsList(options: "영화 제목", type: 0, isRequired: false),
                OptionsList(options: "감독", type: 0, isRequired: false),
                OptionsList(options: "줄거리", type: 0, isRequired: false),
                OptionsList(options: "평점", type: 1, isRequired: false)
            ]
        } else if indexPath.item == 1 {
            nextVC.recommendationOptionsList = [
                OptionsList(options: "책 제목", type: 0, isRequired: false),
                OptionsList(options: "작가", type: 0, isRequired: false),
                OptionsList(options: "줄거리", type: 0, isRequired: false),
                OptionsList(options: "한 구절", type: 0, isRequired: false)
            ]
        } else if indexPath.item == 2 {
            nextVC.recommendationOptionsList = [
                OptionsList(options: "메뉴", type: 0, isRequired: false),
                OptionsList(options: "장소", type: 0, isRequired: false),
                OptionsList(options: "가격", type: 0, isRequired: false),
                OptionsList(options: "평점", type: 1, isRequired: false)
            ]
        } else if indexPath.item == 3 {
            nextVC.recommendationOptionsList = [
                OptionsList(options: "음악 제목", type: 0, isRequired: false),
                OptionsList(options: "앨범 이름", type: 0, isRequired: false),
                OptionsList(options: "가수", type: 0, isRequired: false),
                OptionsList(options: "장르", type: 0, isRequired: false)
            ]
        } else if indexPath.item == 4 {
            nextVC.recommendationOptionsList = [
                OptionsList(options: "공부 주제", type: 0, isRequired: false),
                OptionsList(options: "내용", type: 0, isRequired: false),
                OptionsList(options: "시간", type: 0, isRequired: false),
                OptionsList(options: "만족도", type: 1, isRequired: false)
            ]
        } else if indexPath.item == 5 {
            nextVC.recommendationOptionsList = [
                OptionsList(options: "목표", type: 0, isRequired: true),
                OptionsList(options: "달성", type: 0, isRequired: true),
                OptionsList(options: "피드백", type: 0, isRequired: false)
            ]
        } else if indexPath.item == 6 {
            nextVC.recommendationOptionsList = [
                OptionsList(options: "목표", type: 0, isRequired: true),
                OptionsList(options: "달성", type: 0, isRequired: true),
                OptionsList(options: "운동 주제", type: 0, isRequired: false),
                OptionsList(options: "피드백", type: 0, isRequired: false)
            ]
        } else {
            nextVC.recommendationOptionsList = [
                OptionsList(options: "자유로운 내용", type: 0, isRequired: false)
            ]
        }
        nextVC.category = indexPath.item + 1
//        nextVC.id = id
        nextVC.id = 1
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.categoryCell, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.initCell(imageList[indexPath.row], categoryList[indexPath.row])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 32) / 2
        let height = (collectionView.frame.height - 60) / 4
        return CGSize(width: width, height: height)
    }
}
