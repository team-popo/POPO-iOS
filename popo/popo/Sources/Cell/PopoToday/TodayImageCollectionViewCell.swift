//
//  TodayImageCollectionViewCell.swift
//  popo
//
//  Created by 초이 on 2021/10/19.
//

import UIKit

protocol PopoTodayImageUploadProtocol: AnyObject {
    func uploadImage(_ sender: UITapGestureRecognizer)
}

class TodayImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    weak var popoTodayImageUploadProtocol: PopoTodayImageUploadProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var todayImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTapGestureRecognizer()
    }
    
    // MARK: - Functions
    
    func initCell(image: UIImage, dateArray: [String]) {
        todayImageView.image = image
        dateLabel.text = "\(dateArray[0]). \(dateArray[1]). \(dateArray[2]) \(dateArray[3])"
    }
    
    func addTapGestureRecognizer() {
        let todayImageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadImage(_:)))
        todayImageView.addGestureRecognizer(todayImageTapRecognizer)
        todayImageView.isUserInteractionEnabled = true
    }
    
    // MARK: - @IBAction Function
    
    @objc func uploadImage(_ gesture: UITapGestureRecognizer) {
        popoTodayImageUploadProtocol?.uploadImage(gesture)
    }
}
