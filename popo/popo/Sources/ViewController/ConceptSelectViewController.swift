//
//  conceptSelectViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/25.
//

import UIKit

class ConceptSelectViewController: UIViewController {

    // MARK: - Properties
    private var conceptList = [""]
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var conceptCollectionView: UICollectionView!
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        registerCell()
    }
}

// MARK: - Extenstion Methods
extension ConceptSelectViewController {
    private func setUI() {
        self.conceptList = ["coverExample1", "coverExample2", "coverExample3", "coverExample4"]
        
        titleLabel.text = "나만의 포포를 만들어 볼까요?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4862745098, blue: 0.9333333333, alpha: 1)
        
        subtitleLabel.text = "여러분의 마음에 드는 포포의 컨셉을 정해주세요."
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = #colorLiteral(red: 0.4784313725, green: 0.462745098, blue: 0.462745098, alpha: 1)
    }
    private func registerCell() {
        conceptCollectionView.delegate = self
        conceptCollectionView.dataSource = self
        let conceptCell = UINib(nibName: "ConceptSelectCell", bundle: nil)
        conceptCollectionView.register(conceptCell, forCellWithReuseIdentifier: "ConceptSelectCell")
    }
}

extension ConceptSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conceptList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConceptSelectCell", for: indexPath) as? ConceptSelectCell else {
            return UICollectionViewCell()
        }
        cell.setBackgroundImage(image: conceptList[indexPath.row])
        
        return cell
    }
}

extension ConceptSelectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboard = UIStoryboard.init(name: Const.Storyboard.Name.coverColor, bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.coverColor) as? CoverColorViewController else {
                return
            }

            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.row == 1 {
            let storyboard = UIStoryboard.init(name: Const.Storyboard.Name.coverGradient, bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.coverGradient) as? CoverGradientViewController else {
                return
            }

            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.row == 2 {
            let storyboard = UIStoryboard.init(name: Const.Storyboard.Name.coverCalendar, bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.coverCalendar) as? CoverCalendarViewController else {
                return
            }

            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let storyboard = UIStoryboard.init(name: Const.Storyboard.Name.coverUserPhoto, bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.coverUserPhoto) as? CoverUserPhotoViewController else {
                return
            }

            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension ConceptSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
