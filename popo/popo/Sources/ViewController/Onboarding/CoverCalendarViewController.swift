//
//  CoverCalendarViewController.swift
//  popo
//
//  Created by 초이 on 2021/05/23.
//

import UIKit

class CoverCalendarViewController: UIViewController {
    
    // MARK: - Properties
    
    var coverImageViews: [UIImageView] = []
    var coverStackViews: [UIStackView] = []
    var imagePicker = UIImagePickerController()
    var imageRects: [CGRect] = Array(repeating: CGRect(x: 0, y: 0, width: 0, height: 0), count: 12)
    var dividedImages: [CGImage] = []
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var whiteBgView: UIView!
    @IBOutlet weak var coverImageView1: UIImageView!
    @IBOutlet weak var coverImageView2: UIImageView!
    @IBOutlet weak var coverImageView3: UIImageView!
    @IBOutlet weak var coverImageView4: UIImageView!
    @IBOutlet weak var coverImageView5: UIImageView!
    @IBOutlet weak var coverImageView6: UIImageView!
    @IBOutlet weak var coverImageView7: UIImageView!
    @IBOutlet weak var coverImageView8: UIImageView!
    @IBOutlet weak var coverImageView9: UIImageView!
    @IBOutlet weak var coverImageView10: UIImageView!
    @IBOutlet weak var coverImageView11: UIImageView!
    @IBOutlet weak var coverImageView12: UIImageView!
    @IBOutlet weak var bgStackView: UIStackView!
    @IBOutlet weak var coverStackView1: UIStackView!
    @IBOutlet weak var coverStackView2: UIStackView!
    @IBOutlet weak var coverStackView3: UIStackView!
    @IBOutlet weak var coverStackView4: UIStackView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        makeImageViewArray()
        makeStackViewArray()
        initViewRounding()
        assignDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        setImageRect()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackAndDoneButton(navigationItem: self.navigationItem,
                                                             doneButtonClosure: #selector(pushToConceptViewController(_:)))
    }
    
    private func makeImageViewArray() {
        coverImageViews.append(coverImageView1)
        coverImageViews.append(coverImageView2)
        coverImageViews.append(coverImageView3)
        coverImageViews.append(coverImageView4)
        coverImageViews.append(coverImageView5)
        coverImageViews.append(coverImageView6)
        coverImageViews.append(coverImageView7)
        coverImageViews.append(coverImageView8)
        coverImageViews.append(coverImageView9)
        coverImageViews.append(coverImageView10)
        coverImageViews.append(coverImageView11)
        coverImageViews.append(coverImageView12)
    }
    
    private func makeStackViewArray() {
        coverStackViews.append(coverStackView1)
        coverStackViews.append(coverStackView2)
        coverStackViews.append(coverStackView3)
        coverStackViews.append(coverStackView4)
    }
    
    private func initViewRounding() {
        whiteBgView.makeRounded(radius: 30)
    }
    
    private func assignDelegate() {
        imagePicker.delegate = self
    }
    
    private func setImageRect() {
        for (index, imageView) in coverImageViews.enumerated() {
            let rect = CGRect(
                x: imageView.frame.origin.x,
                y: coverStackViews[index/3].frame.origin.y,
                width: imageView.frame.width,
                height: imageView.frame.height)
            
            imageRects[index] = rect
        }
    }
    
    @objc func pushToConceptViewController(_ sender: UIBarButtonItem) {
        let conceptStoryboard = UIStoryboard(name: Const.Storyboard.Name.concept, bundle: nil)
        guard let conceptViewController = conceptStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.concept) as? ConceptViewController else { return }
        
        conceptViewController.dividedImages = self.dividedImages
        
        self.navigationController?.pushViewController(conceptViewController, animated: true)
    }
    
    // MARK: - @IBAction Functions

    @IBAction func touchPopo(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension CoverCalendarViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // image를 원하는 크기로 resizing
    func resizeImage(image: UIImage, size: CGSize) -> CGImage {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let renderImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let resultImage = renderImage?.cgImage else {
            print("image resizing error")
            return image.cgImage!
        }
        
        return resultImage
    }
    
    // didFinishPickingMediaWithInfo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        self.dividedImages.removeAll()

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let originalSize: CGSize = image.size
            // 보장되어야 하는 최소 width, height값
            let minimumSize: CGSize = CGSize(
                width: coverImageView3.frame.origin.x + coverImageView3.frame.width - coverImageView1.frame.origin.x,
                height: bgStackView.frame.height)
            // 사진의 비율에 맞춰 resize될 CGSize
            var newSize: CGSize = CGSize(width: 0, height: 0)
            
            // 이미지 resizing을 위한 newSize 지정
            // 가로가 더 긴 이미지, 정방형 이미지
            if originalSize.width >= originalSize.height {
                
                newSize.width = minimumSize.height * originalSize.width / originalSize.height
                newSize.height = minimumSize.height
                
            // 세로가 더 긴 이미지
            } else {
                
                newSize.width = minimumSize.width * originalSize.height / originalSize.height
                newSize.height = minimumSize.height
                
            }
            
            // 이미지 resizing
            var resizedImage = resizeImage(image: image, size: newSize)
            
            // 이미지 cropping - 중앙 crop
            let centerRect = CGRect(
                x: CGFloat(resizedImage.width / 2 - Int(minimumSize.width) / 2),
                y: CGFloat(resizedImage.height / 2 - Int(minimumSize.height) / 2),
                width: minimumSize.width,
                height: minimumSize.height)
            
            resizedImage = resizedImage.cropping(to: centerRect)!

            // 이미지 cropping - 12분할
            for idx in 0..<12 {
                let dividedImage = resizedImage.cropping(to: imageRects[idx])
                dividedImages.append(dividedImage!)
            }
            
            // 각 위치에 맞는 imageView에 Image 넣기
            for (index, image) in dividedImages.enumerated() {
                coverImageViews[index].image = UIImage(cgImage: image)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
