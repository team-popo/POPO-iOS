//
//  OptionsViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/13.
//

import UIKit

class OptionsViewController: UIViewController {
    
    // MARK: - Porperties
    
    private var recommendationOptionsList = [String]()
    private var optionsList = [RecommendationOptionView]()
    
    enum Size {
        static let cellLeftRightSpacing: CGFloat = 50
        static let cellInterItemSpacing: CGFloat = 16
        static let cellLineSpacing: CGFloat = 24
        static let optionHeight: CGFloat = 70
        static let stackViewLineSpacing: CGFloat = 20
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var optionsStackView: UIStackView!
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecommendationOptionsList()
        setUI()
        initNavigationBar()
        registerCell()
        initNotification()
    }
}

// MARK: - Extensions

extension OptionsViewController {
    private func setUI() {
        scrollView.contentInsetAdjustmentBehavior = .never
        
        recommendationCollectionView.backgroundColor = .clear
        let recommendationOptionView = RecommendationOptionView(title: recommendationOptionsList[0])
        let plusOptionView = PlustOptionView()
        
        optionsList.append(recommendationOptionView)
        optionsStackView.distribution = .fill
        optionsStackView.spacing = Size.stackViewLineSpacing
        optionsStackView.addArrangedSubview(recommendationOptionView)
        optionsStackView.addArrangedSubview(plusOptionView)
        optionsStackView.arrangedSubviews.forEach {
            $0.heightAnchor.constraint(equalToConstant: Size.optionHeight).isActive = true
        }
        
        recommendationCollectionView.allowsMultipleSelection = true
    }
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackAndDoneButton(navigationItem: self.navigationItem, doneButtonClosure: #selector(pushToConceptViewController))
     }
    
    private func registerCell() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        let nib = UINib(nibName: Const.Xib.recommendationCollectionViewCell, bundle: nil)
        recommendationCollectionView.register(nib, forCellWithReuseIdentifier: Const.Xib.recommendationCollectionViewCell)
    }
    private func initRecommendationOptionsList() {
        // later initialize server data instead dummy data
        recommendationOptionsList.append(contentsOf: ["제목",
                                                      "저자",
                                                      "줄거리",
                                                      "인상 깊은 내용"])
    }
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeOption(_:)), name: .removeOption, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(plusOption), name: .plusOption, object: nil)
    }
    
    @objc
    private func pushToConceptViewController() {
        // TODO: 화면전환
    }
    
    @objc
    private func removeOption(_ notification: Notification) {
        guard let title = notification.object as? String else { return }
        // remove from optionsList, optionsStackView
        var removeOptionIndex = -1
        for (index, value) in optionsList.enumerated() where value.getOptionTitle() == title {
            removeOptionIndex = index
        }
        let removeOptionView = optionsList.remove(at: removeOptionIndex)
        optionsStackView.removeArrangedSubview(removeOptionView)
        removeOptionView.removeFromSuperview()
        
        // deselect colletionView cell
        for (index, value) in recommendationOptionsList.enumerated() where value == title {
            recommendationCollectionView.deselectItem(at: IndexPath(item: index, section: 0), animated: true)
        }
        
    }
    
    @objc
    private func plusOption() {
        let storyboard = UIStoryboard(name: Const.Storyboard.Name.customOptions, bundle: nil)
        guard let popVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.customOptions) as? CustomOptionsViewController else {
            return
        }
        popVC.modalTransitionStyle = .crossDissolve
        popVC.modalPresentationStyle = .overFullScreen
        self.present(popVC, animated: true, completion: nil)
        
    }
}

// MARK: - UICollectionViewDelegate

extension OptionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recommendationOptionView = RecommendationOptionView(title: recommendationOptionsList[indexPath.item])
        optionsList.append(recommendationOptionView)
        
        if optionsList.count == 0 {
            optionsStackView.insertArrangedSubview(recommendationOptionView, at: 0)
        } else {
            optionsStackView.insertArrangedSubview(recommendationOptionView, at: optionsList.count - 1)
        }
        recommendationOptionView.heightAnchor.constraint(equalToConstant: Size.optionHeight).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // remove from optionsList, optionsStackView
        var removeIndex = -1
        for (index, value) in optionsList.enumerated() where value.getOptionTitle() == recommendationOptionsList[indexPath.item] {
            removeIndex = index
        }
        let removeOptionView = optionsList.remove(at: removeIndex)
        optionsStackView.removeArrangedSubview(removeOptionView)
        removeOptionView.removeFromSuperview()
    }
}

// MARK: - UICollectionViewDataSource

extension OptionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationOptionsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.recommendationCollectionViewCell, for: indexPath) as? RecommendationCollectionViewCell else {
            return UICollectionViewCell()
        }
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .init())
        cell.initCell(recommendationOptionsList[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OptionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Size.cellInterItemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.recommendationCollectionViewCell, for: indexPath) as? RecommendationCollectionViewCell else {
            return .zero
        }
        cell.initCell(recommendationOptionsList[indexPath.item])
        cell.recommendationOptionsLabel.sizeToFit()
        let cellWidth = cell.recommendationOptionsLabel.frame.width + Size.cellLeftRightSpacing
        let cellHeigt = (collectionView.frame.height - Size.cellLineSpacing ) / 2
        
        return CGSize(width: cellWidth, height: cellHeigt)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
