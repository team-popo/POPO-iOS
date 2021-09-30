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
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCategoryList()
        registerCell()
    }

    // MARK: - @IBAction Properties
    
    @IBAction func popToConcept(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Extensions

extension CategoryViewController {
    private func setUI() {
        categoryCollectionView.backgroundColor = .clear
    }
    
    private func setCategoryList() {
        categoryList.append(contentsOf: ["영화",
                                         "책",
                                         "음식",
                                         "음악",
                                         "공부",
                                         "물",
                                         "운동",
                                         "기타"])
        imageList.append(contentsOf: ["",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    ""])
    }
    
    private func registerCell() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        let cateogoryCell = UINib(nibName: Const.Xib.CategoryCell, bundle: nil)
        categoryCollectionView.register(cateogoryCell, forCellWithReuseIdentifier: Const.Xib.CategoryCell)
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.CategoryCell, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.initCell(imageList[indexPath.row], categoryList[indexPath.row])
        
        return cell
    }
}

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
