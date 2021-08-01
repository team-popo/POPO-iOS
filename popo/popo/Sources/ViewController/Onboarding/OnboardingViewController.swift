//
//  OnboardingViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/07/20.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var onboardingList: [OnboardingDescriptionModel] = []
    private var currentPage = 0
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("포포 시작하기", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4862745098, blue: 0.9333333333, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.makeRounded(radius: 25)
        button.addTarget(self, action: #selector(presentToConceptSelect), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerCell()
        setList()
    }
}
 
// MARK: - Extenstions

extension OnboardingViewController {
    
    // MARK: - @objc Methods
    
    @objc
    func presentToConceptSelect() {
        guard let nextVC = UIStoryboard(name: Const.Storyboard.Name.conceptSelect, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Identifier.conseptSelect) as? UINavigationController else {
            return
        }
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.modalPresentationStyle = .currentContext
        
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    private func setUI() {
        onboardingCollectionView.isPagingEnabled = true
        onboardingCollectionView.showsHorizontalScrollIndicator = false
        
        let layout = onboardingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        
        setNextButton()
    }
    
    private func registerCell() {
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        let onboardingCell = UINib(nibName: OnboardingCell.identifier, bundle: nil)
        onboardingCollectionView.register(onboardingCell, forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
    
    private func setList() {
        onboardingList.append(contentsOf: [
            OnboardingDescriptionModel(title: "주제별로 기록해요", subtitle: "12개의 컨셉을 선택해\n 각자 다른 주제의 포포를 만들어 보세요!", pageImage: "pageControllerImg1", image: "onboardingPhoneImg1"),
            OnboardingDescriptionModel(title: "한눈에 확인해요", subtitle: "각 포포에서 내가 기록한\n 썸네일을 한눈에 볼 수 있어요!", pageImage: "pageControllerImg2", image: "onboardingPhoneImg2"),
            OnboardingDescriptionModel(title: "원하는 대로 기록해요", subtitle: "내가 기록하고 싶은\n 항목을 내 맘대로 설정할 수 있어요!", pageImage: "pageControllerImg3", image: "onboardingPhoneImg3")
        ])
    }
    
    private func setNextButton() {
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 55),
            nextButton.widthAnchor.constraint(equalToConstant: 300),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: onboardingCollectionView.bottomAnchor, constant: -20)
        ])
        nextButton.alpha = 0
    }
}

// MARK: - UICollectionViewDelegate

extension OnboardingViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNum = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        
        if pageNum == 2 {
            UIView.animate(withDuration: 1) {
                self.nextButton.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.nextButton.alpha = 0
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        cell.initCell(title: onboardingList[indexPath.row].title, subtitle: onboardingList[indexPath.row].subtitle, pageImage: onboardingList[indexPath.row].pageImage, imageView: onboardingList[indexPath.row].image)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = onboardingCollectionView.frame.size.width
        let height = onboardingCollectionView.frame.size.height
        
        return CGSize(width: width, height: height)
    }
}
