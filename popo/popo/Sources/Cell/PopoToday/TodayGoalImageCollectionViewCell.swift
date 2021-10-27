//
//  ParticularTodayImageCollectionViewCell.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/20.
//

import UIKit
import Kingfisher

class TodayGoalImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    var popoId: Int?
    var goalContentsID: Int?
    var acheivementContentsID: Int?
    var updateImage: UIImage?
    var dayId: Int?
    var category: Int?
    
    weak var reloadCalendarProtocol: ReloadCalendarProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goalBolderView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var goalContentTextView: UITextView!
    @IBOutlet weak var acheivementBolderView: UIView!
    @IBOutlet weak var acheivementContentTextView: UITextView!
    @IBOutlet weak var goalLineView: UIView!
    @IBOutlet weak var acheivementLineView: UIView!
    @IBOutlet weak var goalEditButton: UIButton!
    @IBOutlet weak var acheivementEditButton: UIButton!
    
    // MARK: - Cell Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    private func setUI() {
        goalBolderView.makeRoundedWithBorder(radius: 30, color: UIColor.systemGray2.cgColor)
        goalContentTextView.textContainerInset = .zero
        
        acheivementBolderView.makeRoundedWithBorder(radius: 30, color: UIColor.systemGray2.cgColor)
        acheivementContentTextView.textContainerInset = .zero
        imageView.makeRounded(radius: 30)
        descriptionLabel.sizeToFit()
    }
    
    func initCell(_ image: UIImage,
                  _ dateArray: [String]) {
        descriptionLabel.isHidden = false
        dateLabel.text = "\(dateArray[0]). \(dateArray[1]). \(dateArray[2]) \(dateArray[3])"
    }
    
    func initCell(_ imageURL: String,
                  _ goalContent: String,
                  _ acheivementContent: String,
                  _ date: String) {
        descriptionLabel.isHidden = true
            imageView.updateServerImage(imageURL)
        goalContentTextView.text = goalContent
        acheivementContentTextView.text = acheivementContent
        dateLabel.text = AppDate().getFormattedDateAndWeekday(with: ".")
    }
    
    func initEditingStatus(isEditing: Bool) {
        goalContentTextView.isEditable = isEditing
        acheivementContentTextView.isEditable = isEditing
        goalContentTextView.isScrollEnabled = isEditing
        acheivementContentTextView.isScrollEnabled = isEditing
        goalEditButton.isHidden = isEditing
        acheivementEditButton.isHidden = isEditing
        goalLineView.isHidden = !isEditing
        acheivementLineView.isHidden = !isEditing
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchGoalEditButton(_ sender: UIButton) {
        goalContentTextView.isEditable.toggle()
        goalContentTextView.isScrollEnabled.toggle()
        goalLineView.isHidden.toggle()
        goalContentTextView.becomeFirstResponder()
        
        if goalContentTextView.isEditable {
            goalEditButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
            goalEditButton.tintColor = .black
        } else {
            goalEditButton.setImage(UIImage(systemName: "highlighter"), for: .normal)
            goalEditButton.tintColor = .systemGray2
            
            guard let popoId = popoId, let dayId = dayId, let contentsId = goalContentsID else { return }
            
            patchTodayPatch(popoID: popoId, dayID: 0, contentsID: contentsId, contents: goalContentTextView.text, sender: sender)
            
            // 이미지 업데이트
            let acheivementContentTextView = Float(acheivementContentTextView.text)
            let goalContentTextView = Float(goalContentTextView.text)
            let updateImage = makeGoalRatioImage(category: category ?? 0, acheivementContent: acheivementContentTextView ?? 0, goalContent: goalContentTextView ?? 0)
            patchTodayImage(popoId: popoId, dayId: dayId, image: updateImage)
        }
    }
    
    @IBAction func touchAcheivementEditButton(_ sender: UIButton) {
        acheivementContentTextView.isEditable.toggle()
        acheivementContentTextView.isScrollEnabled.toggle()
        acheivementLineView.isHidden.toggle()
        acheivementContentTextView.becomeFirstResponder()
        
        if acheivementContentTextView.isEditable {
            acheivementEditButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
            acheivementEditButton.tintColor = .black
        } else {
            acheivementEditButton.setImage(UIImage(systemName: "highlighter"), for: .normal)
            acheivementEditButton.tintColor = .systemGray2
            
            guard let popoId = popoId, let dayId = dayId, let contentsId = acheivementContentsID else { return }
            
            patchTodayPatch(popoID: popoId, dayID: 1, contentsID: contentsId, contents: acheivementContentTextView.text, sender: sender)
            
            // 이미지 업데이트
            let acheivementContentTextView = Float(acheivementContentTextView.text)
            let goalContentTextView = Float(goalContentTextView.text)
            let updateImage = makeGoalRatioImage(category: category ?? 0, acheivementContent: acheivementContentTextView ?? 0, goalContent: goalContentTextView ?? 0)
            patchTodayImage(popoId: popoId, dayId: dayId, image: updateImage)
        }

    }
    
    func setData(popoId: Int, dayId: Int, category: Int, goalContentsID: Int, acheivementContentsID: Int) {
        self.popoId = popoId
        self.dayId = dayId
        self.category = category
        self.goalContentsID = goalContentsID
        self.acheivementContentsID = acheivementContentsID
    }
    
    private func makeGoalRatioImage(category: Int, acheivementContent: Float, goalContent: Float) -> UIImage {
        if category == 6 {
            let goalRatio: Float = (acheivementContent / goalContent) * 100
            var goalRatioImage = UIImage()
            switch goalRatio {
            case 0.0..<25.0:
                goalRatioImage = UIImage(named: "water0")!
                return goalRatioImage
            case 25.0..<50.0:
                goalRatioImage = UIImage(named: "water25")!
                return goalRatioImage
            case 50.0..<75.0:
                goalRatioImage = UIImage(named: "water50")!
                return goalRatioImage
            case 75.0..<100.0:
                goalRatioImage = UIImage(named: "water75")!
                return goalRatioImage
            default:
                goalRatioImage = UIImage(named: "water100")!
                return goalRatioImage
            }
        } else {
            let goalRatio: Float = (acheivementContent / goalContent) * 100
            var goalRatioImage = UIImage()
            switch goalRatio {
            case 0.0..<25.0:
                goalRatioImage = UIImage(named: "pie0")!
                return goalRatioImage
            case 25.0..<50.0:
                goalRatioImage = UIImage(named: "pie25")!
                return goalRatioImage
            case 50.0..<75.0:
                goalRatioImage = UIImage(named: "pie50")!
                return goalRatioImage
            case 75.0..<100.0:
                goalRatioImage = UIImage(named: "pie75")!
                return goalRatioImage
            default:
                goalRatioImage = UIImage(named: "pie100")!
                return goalRatioImage
            }
        }
    }
}
// 통신

extension TodayGoalImageCollectionViewCell {
    func patchTodayPatch(popoID: Int, dayID: Int, contentsID: Int, contents: String, sender: UIButton) {
    
        TodayAPI.shared.patchTodayPatch(popoID: popoID, dayID: dayID, contentsID: contentsID, contents: contents) { (response) in
            switch response {
            case .success(_):
                sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                print("수정 성공")
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func patchTodayImage(popoId: Int, dayId: Int, image: UIImage) {
        
        TodayAPI.shared.patchTodayImage(popoId: popoId, dayId: dayId, image: image) { (response) in
            switch response {
            case .success(_):
                // 이미지 업로드 성공
                self.imageView.image = image
//                self.reloadCalendarProtocol?.reloadCalendar()
                print("success - patchTodayImage")
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
