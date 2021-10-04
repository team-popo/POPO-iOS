//
//  CoverUserPhotoViewController.swift
//  popo
//
//  Created by 초이 on 2021/05/23.
//

import UIKit

class CoverUserPhotoViewController: UIViewController {

    // MARK: - Properties
    
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
    
    var coverImageViews: [UIImageView] = []
    
    var imagePicker = UIImagePickerController()
    var currentPickerIndex = Int.max
    // TODO: - 유저가 이미지 선택 안 했을 시 기본 이미지 넣을건지? 그러면 repeating값 기본 이미지로 수정
    var selectedCoverImages: [UIImage] = Array(repeating: UIImage(), count: 11)
    
    // MARK: - @IBOutlet Properties
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeImageViewArray()
        initViewRounding()
        initNavigationBar()
        assignDelegate()
        initTapGesterRecognizer()
    }
    
    // MARK: - Functions
    
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
    
    private func initViewRounding() {
        whiteBgView.makeRounded(radius: 30)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackAndDoneButton(
            navigationItem: self.navigationItem,
            doneButtonClosure: #selector(touchDoneButton(_:)))
    }
    
    private func assignDelegate() {
        imagePicker.delegate = self
    }
    
    private func initTapGesterRecognizer() {
        for (index, coverImageView) in coverImageViews.enumerated() {
            let coverTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchCover(_:)))
            coverTapRecognizer.numberOfTapsRequired = 1
            coverImageView.tag = index
            coverImageView.isUserInteractionEnabled = true
            coverImageView.addGestureRecognizer(coverTapRecognizer)
        }
    }
    
    // MARK: - @IBAction Functions
    
    @objc func touchCover(_ sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        guard let senderTag = sender.view?.tag else { return }
        currentPickerIndex = senderTag
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func touchDoneButton(_ sender: UIBarButtonItem) {
        let calendarStoryboard = UIStoryboard(name: Const.Storyboard.Name.calendar, bundle: nil)
        guard let calendarViewController = calendarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.calendar) as? CalendarViewController else { return }
        self.navigationController?.pushViewController(calendarViewController, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension CoverUserPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // didFinishPickingMediaWithInfo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        // 선택한 이미지 커버 이미지뷰의 이미지로 변경
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            coverImageViews[currentPickerIndex].image = image
            selectedCoverImages[currentPickerIndex] = image
        }
        dismiss(animated: true, completion: nil)
    }
}
