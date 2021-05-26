//
//  DescriptionViewController.swift
//  popo
//
//  Created by kimhyungyu on 2021/05/24.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    // MARK: - Properties
//    private var contentPage: UIPageViewController!
    private var pageImages = [""]
    private var currnetIdx = 0
    private var chooseIdx = 0
    private let contentPage = UIPageViewController(transitionStyle: .scroll,
                                                              navigationOrientation: .horizontal)
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageImages = ["descriptionTopic", "descriptionThumb", "descriptionOption" ]
        
//        self.contentPage = UIStoryboard(name: Const.Storyboard.Name.contentDescription, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Identifier.contentDescription) as? UIPageViewController
        
        self.contentPage.delegate = self
        self.contentPage.dataSource = self
        
//        let startVC = self.contentPage.view.tag = chooseIdx
        let firstVC = instantiateViewController(index: 0)
        contentPage.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
        //  페이지 뷰컨을 부모 뷰컨에 띄워줍니다
//        mainView.addSubview(contentPage)
        
        addChild(contentPage)
        view.addSubview(contentPage.view)
        contentPage.didMove(toParent: self)
        
        pageControl.numberOfPages = pageImages.count
        
        setUI()
    }

}

// MARK: - Extenstion Methods
extension DescriptionViewController {
    private func setUI() {
        pageControl.currentPageIndicatorTintColor = .white   // 현재 페이지 인디케이터 색
        pageControl.pageIndicatorTintColor = .systemGray        // 나머지 페이지 인디케이터 색
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func instantiateViewController(index: Int) -> UIViewController {
        guard let vc = UIStoryboard(name: Const.Storyboard.Name.contentDescription, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Identifier.contentDescription) as? ContentDescriptionViewController else {
            return UIViewController()
        }
        vc.view.tag = index
        vc.backgroundImage.image = UIImage(named: pageImages[index])
        return vc
    }
}

// MARK: -
extension DescriptionViewController: UIPageViewControllerDelegate {
    
    //  스와이프 제스쳐가 끝나면 호출되는 메서드입니다. 여기서 페이지 컨트롤의 인디케이터를 움직여줄꺼에요
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool
    ) {
        //  페이지 이동이 안됐으면 그냥 종료
        guard completed else { return }
        
        //  페이지 이동이 됐기 때문에 페이지 컨트롤의 인디케이터를 갱신해줍시다
        if let vc = pageViewController.viewControllers?.first {
            pageControl.currentPage = vc.view.tag
        }
    }
}

// MARK: -
extension DescriptionViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        //  컨텐츠 뷰컨을 생성할 때 태그에 인덱스를 넣어줬기 때문에 몇번째 페이지인지 바로 알 수 있어요
        guard let index = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }
        
        // 이전 인덱스를 계산해주고요
        let nextIndex = index > 0 ? index - 1 : pageImages.count - 1
        
        // 이전 컨텐츠를 담은 뷰컨을 생성해서 리턴해줍니다
        let nextVC = instantiateViewController(index: nextIndex)
        return nextVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }
        let nextIndex = (index + 1) % pageImages.count
        let nextVC = instantiateViewController(index: nextIndex)
        return nextVC
    }
    // 인디케이터 개수
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageImages.count
    }

    // 인디케이터 초기 선택 값
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return chooseIdx
    }
}
