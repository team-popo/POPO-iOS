//
//  ConceptViewController.swift
//  popo
//
//  Created by 초이 on 2021/05/26.
//

import UIKit

class ConceptViewController: UIViewController {
    
    // MARK: - Properties
    
    var conceptImageViews = [UIImageView]()
    var dividedImages = [CGImage]()
    var conceptDataList = [Concept]()
    enum Size {
        static let cellLineSpacing: CGFloat = 16
        static let cellInterItemSpacing: CGFloat  = 16
    }
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var whiteBgView: UIView!

    @IBOutlet weak var conceptCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initWhiteBgView()
        getPopoListWithAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
}
    
// MARK: - Extensions

extension ConceptViewController {
    private func initNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true

    }
    
    private func initWhiteBgView() {
        whiteBgView.makeRounded(radius: 30)
        whiteBgView.makeShadow(color: UIColor.black,
                               offset: CGSize(width: 0, height: 4),
                               radius: 4,
                               opacity: 0.25)
        
        // 그림자를 캐시에 저장해 재사용
        whiteBgView.layer.shouldRasterize = true
    }
    
    // 서버통신
    func getPopoListWithAPI() {
        PopoAPI.shared.getPopoList { result  in
            print(result)
        }
    }
    
    func registerCell() {
        let nib = UINib(nibName: Const.Xib.conceptCollectionViewCell, bundle: nil)
        conceptCollectionView.register(nib, forCellWithReuseIdentifier: Const.Xib.conceptCollectionViewCell)
    }
}

// MARK: - UICollectionViewDelegate

extension ConceptViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if conceptDataList[indexPath.item].conceptID == 1 {
            let storyboard = UIStoryboard(name: Const.Storyboard.Name.calendar, bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.calendar) as? CalendarViewController else {
                return
            }
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: Const.Storyboard.Name.category, bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.category) as? CategoryViewController else {
                return
            }
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ConceptViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conceptDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.conceptCollectionViewCell, for: indexPath) as? ConceptCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.initCell(conceptDataList[indexPath.item].background)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ConceptViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - 2 * Size.cellLineSpacing
        let cellHeight = collectionView.frame.height - 3 * Size.cellInterItemSpacing
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
