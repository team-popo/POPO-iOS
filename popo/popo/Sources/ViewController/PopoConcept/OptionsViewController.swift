//
//  OptionsViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/13.
//

import UIKit

class OptionsViewController: UIViewController {
    
    // MARK: - Porperties
    
    var recommendationOptionsList = [OptionsList?]()
    var category: Int?
    var id: Int?
    
    private var optionViewList = [OptionView]()
    private var optionsCollectionViewList = [OptionsList]()
    private var optionsParameter = [OptionsList]()
    
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
        setUI()
        initOptionsStackView()
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
        recommendationCollectionView.allowsMultipleSelection = true
    }
    
    private func initOptionsStackView() {
        guard let recommendationOptionsList = recommendationOptionsList as? [OptionsList] else { return }
        if recommendationOptionsList[0].isRequired {
            // required options
            for value in recommendationOptionsList {
                if value.isRequired {
                    optionsParameter.append(value)
                    let recommendationOptionView = OptionView(title: value.options,
                                                                            isRequired: value.isRequired)
                    optionViewList.append(recommendationOptionView)
                    optionsStackView.addArrangedSubview(recommendationOptionView)
                } else {
                    // add to optionsCollectionViewList
                    optionsParameter.append(value)
                    optionsCollectionViewList.append(value)
                }
            }
            let recommendationOptionView = OptionView(title: optionsCollectionViewList[0].options)
            let plusOptionView = PlusOptionView()
            
            optionViewList.append(recommendationOptionView)
            
            optionsStackView.addArrangedSubview(recommendationOptionView)
            optionsStackView.addArrangedSubview(plusOptionView)
            optionsStackView.distribution = .fill
            optionsStackView.spacing = Size.stackViewLineSpacing
            optionsStackView.arrangedSubviews.forEach {
                $0.heightAnchor.constraint(equalToConstant: Size.optionHeight).isActive = true
            }
        } else {
            // required options nothing
            // add to optionsCollectionViewList
            optionsCollectionViewList = recommendationOptionsList
            optionsParameter.append(recommendationOptionsList[0])
            
            let recommendationOptionView = OptionView(title: optionsCollectionViewList[0].options)
            let plusOptionView = PlusOptionView()
            
            optionViewList.append(recommendationOptionView)
            
            optionsStackView.addArrangedSubview(recommendationOptionView)
            optionsStackView.addArrangedSubview(plusOptionView)
            optionsStackView.distribution = .fill
            optionsStackView.spacing = Size.stackViewLineSpacing
            optionsStackView.arrangedSubviews.forEach {
                $0.heightAnchor.constraint(equalToConstant: Size.optionHeight).isActive = true
            }
        }
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
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeOption(_:)), name: .removeOption, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(plusOption), name: .plusOption, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addCustomOption(_:)), name: .addCustomOption, object: nil)
    }
    
// TODO: 서버통신 해결
//    private func insertPopoWithAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
//        //        optionsParameter
//        var insertPopoRequest: InsertPopoRequest
//        var options = [Options]()
//        for (index, parameter) in optionsParameter.enumerated() {
//            options.append(Options(name: parameter.options, order: index, type: parameter.type))
//        }
//        insertPopoRequest = InsertPopoRequest(category: self.category ?? -1, id: id ?? -1, options: options)
//        print(insertPopoRequest)
//        PopoAPI.shared.postInsertPopo(parameter: insertPopoRequest) { result in
//            completion(result)
//        }
//    }
    
    @objc
    private func pushToConceptViewController() {
//        insertPopoWithAPI { result in
//            switch result {
//            case .success(_) :
//                let storyboard = UIStoryboard(name: Const.Storyboard.Name.concept, bundle: nil)
//                guard let nextVC = storyboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.concept) as? ConceptViewController else { return }
//                self.navigationController?.pushViewController(nextVC, animated: true)
//            case .requestErr(let message):
//                print("getPopoListWithAPI - requestErr: \(message)")
//            case .pathErr:
//                print("getPopoListWithAPI - pathErr")
//            case .serverErr:
//                print("getPopoListWithAPI - serverErr")
//            case .networkFail:
//                print("getPopoListWithAPI - networkFail")
//            }
//        }
    }
    
    @objc
    private func removeOption(_ notification: Notification) {
        guard let title = notification.object as? String else { return }
        // remove from optionsList, optionsStackView
        var removeOptionIndex = -1
        for (index, value) in optionViewList.enumerated() where value.getOptionTitle() == title {
            removeOptionIndex = index
        }
        let removeOptionView = optionViewList.remove(at: removeOptionIndex)
        optionsStackView.removeArrangedSubview(removeOptionView)
        removeOptionView.removeFromSuperview()
        
        // remove optionsParameter
        for (index, value) in optionsParameter.enumerated() where value.options == title {
            optionsParameter.remove(at: index)
        }
        
        // deselect colletionView cell
        for (index, value) in optionsCollectionViewList.enumerated() where value.options == title {
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
    
    @objc
    private func addCustomOption(_ notification: Notification) {
        guard let option = notification.object as? OptionsList else { return }
        optionsParameter.append(option)
        
        let optionView = OptionView(title: option.options)
        optionViewList.append(optionView)
        
        if optionViewList.count == 0 {
            optionsStackView.insertArrangedSubview(optionView, at: 0)
        } else {
            optionsStackView.insertArrangedSubview(optionView, at: optionViewList.count - 1)
        }
        optionView.heightAnchor.constraint(equalToConstant: Size.optionHeight).isActive = true
    }
}

// MARK: - UICollectionViewDelegate

extension OptionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // add optionsParameter
        optionsParameter.append(optionsCollectionViewList[indexPath.item])
        
        let recommendationOptionView = OptionView(title: optionsCollectionViewList[indexPath.item].options)
        optionViewList.append(recommendationOptionView)
        
        if optionViewList.count == 0 {
            optionsStackView.insertArrangedSubview(recommendationOptionView, at: 0)
        } else {
            optionsStackView.insertArrangedSubview(recommendationOptionView, at: optionViewList.count - 1)
        }
        recommendationOptionView.heightAnchor.constraint(equalToConstant: Size.optionHeight).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // remove optionsParameter
        for (index, value) in optionsParameter.enumerated() where value.options == optionsCollectionViewList[indexPath.item].options {
            optionsParameter.remove(at: index)
        }
        
        // remove from optionsViewList, optionsStackView
        var removeIndex = -1
        for (index, value) in optionViewList.enumerated() where value.getOptionTitle() == optionsCollectionViewList[indexPath.item].options {
            removeIndex = index
        }
        let removeOptionView = optionViewList.remove(at: removeIndex)
        optionsStackView.removeArrangedSubview(removeOptionView)
        removeOptionView.removeFromSuperview()
    }
}

// MARK: - UICollectionViewDataSource

extension OptionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionsCollectionViewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.recommendationCollectionViewCell, for: indexPath) as? RecommendationCollectionViewCell else {
            return UICollectionViewCell()
        }
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .init())
        cell.initCell(optionsCollectionViewList[indexPath.item].options)
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
        cell.initCell(optionsCollectionViewList[indexPath.item].options)
        cell.recommendationOptionsLabel.sizeToFit()
        let cellWidth = cell.recommendationOptionsLabel.frame.width + Size.cellLeftRightSpacing
        let cellHeigt = (collectionView.frame.height - Size.cellLineSpacing ) / 2
        
        return CGSize(width: cellWidth, height: cellHeigt)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
