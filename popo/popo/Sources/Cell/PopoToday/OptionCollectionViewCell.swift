//
//  OptionCollectionViewCell.swift
//  popo
//
//  Created by 초이 on 2021/10/19.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var popoId: Int?
    var dayId: Int?
    var contentsId: Int?
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    // MARK: - Functions
    
    func initUI() {
        borderView.makeRoundedWithBorder(radius: 30, color: UIColor.systemGray2.cgColor)
        contentTextView.textContainerInset = .zero
    }
    
    func initCell(title: String, content: String) {
        titleLabel.text = title
        contentTextView.text = content
    }
    
    func initEditingStatus(isEditing: Bool) {
        contentTextView.isEditable = isEditing
        contentTextView.isScrollEnabled = isEditing
        editButton.isHidden = isEditing
        lineView.isHidden = !isEditing
    }
    
    func setData(popoId: Int, dayId: Int, contentsId: Int) {
        self.popoId = popoId
        self.dayId = dayId
        self.contentsId = contentsId
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchEditButton(_ sender: UIButton) {
        contentTextView.isEditable.toggle()
        contentTextView.isScrollEnabled.toggle()
        lineView.isHidden.toggle()
        contentTextView.becomeFirstResponder()
        
        if contentTextView.isEditable {
            editButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
            editButton.tintColor = .black
        } else {
            editButton.setImage(UIImage(systemName: "highlighter"), for: .normal)
            editButton.tintColor = .systemGray2
            
            guard let popoId = popoId, let dayId = dayId, let contentsId = contentsId else { return }
            
            patchTodayPatch(popoID: popoId, dayID: dayId, contentsID: contentsId, contents: contentTextView.text)
        }
    }
}

// 통신

extension OptionCollectionViewCell {
    func patchTodayPatch(popoID: Int, dayID: Int, contentsID: Int, contents: String) {
    
        TodayAPI.shared.patchTodayPatch(popoID: popoID, dayID: dayID, contentsID: contentsID, contents: contents) { (response) in
            switch response {
            case .success(let data):
                self.editButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
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
}
