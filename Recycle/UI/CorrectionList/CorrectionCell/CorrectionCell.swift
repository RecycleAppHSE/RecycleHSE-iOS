//
//  CorrectionCell.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.12.2020.
//

import UIKit

class CorrectionCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var toWasteTypesView: WasteTypesView!
    @IBOutlet weak var fromWasteTypesView: WasteTypesView!
    
    @IBOutlet weak var fromStatusLabel: UILabel!
    
    @IBOutlet weak var toStatusLabel: UILabel!
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var fromStatusImageView: UIImageView!
    @IBOutlet weak var toStatusImageView: UIImageView!
    
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var typesContainer: UIView!
    
    @IBOutlet weak var likesContainer: UIView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    var point: RecyclePoint!
    var correction: Correction!
    
    @Inject var service: CorrectionService
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fromWasteTypesView.setupSmall()
        toWasteTypesView.setupSmall()
    }
    
    func configure() {
        addressLabel.text = point.address
        nameLabel.text = point.name
        
        let date = Date(timeIntervalSince1970: correction.submitTime)
        let dateText = Self.formatter.string(from: date)
        let status = correction.status
        dateLabel.text = "Исправления внесены \(dateText). \(status.text)."
        statusImageView.image = status.image
        
        let likeText = " \(correction.likeCount)"
        likeButton.setTitle(likeText, for: .normal)
        likeButton.setTitle(likeText, for: .selected)
        
        let dislikeText = " \(correction.dislikeCount)"
        dislikeButton.setTitle(dislikeText, for: .normal)
        dislikeButton.setTitle(dislikeText, for: .selected)
        
        let isLiked = Self.likedIds.contains(correction.id)
        let isDisliked = Self.dislikedIds.contains(correction.id)
        
        likeButton.isSelected = isLiked
        dislikeButton.isSelected = isDisliked
        
        let isSelf = correction.isSelf
        likeButton.isEnabled = isSelf
        dislikeButton.isEnabled = isSelf
        
        
    }
    
    @IBAction func likeTapped(_ sender: Any) {
        service.set(isLiked: 1, for: correction.id) { [weak self] result in
            switch result {
            case .success:
                self?.likeButton.isSelected = true
            case .failure:
                break
            }
        }
    }
    
    @IBAction func dislikeTapped(_ sender: Any) {
        service.set(isLiked: -1, for: correction.id) { [weak self] result in
            switch result {
            case .success:
                self?.dislikeButton.isSelected = true
            case .failure:
                break
            }
        }
    }
    
    func unlike() {
        service.set(isLiked: 0, for: correction.id) { [weak self] result in
            switch result {
            case .success:
                self?.likeButton.isSelected = false
                self?.dislikeButton.isSelected = false
            case .failure:
                break
            }
        }
    }
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.M.yyyy в HH:mm"
        return formatter
    }()
    
    static var likedIds = [Int]()
    static var dislikedIds = [Int]()
}
