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
    
    
    @IBOutlet weak var selfLikeContainer: UIView!
    @IBOutlet weak var selfLikeButton: UIButton!
    @IBOutlet weak var selfDislikeButton: UIButton!
    
    
    var point: RecyclePoint?
    var correction: Correction!
    
    @Inject var service: CorrectionService
    @Inject var userService: UserService
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fromWasteTypesView.setupSmall()
        toWasteTypesView.setupSmall()
    }
    
    func configure() {
        addressLabel.text = point?.address
        nameLabel.text = point?.name
        
        let date = Date(timeIntervalSince1970: correction.submitTime)
        let dateText = Self.formatter.string(from: date)
        let status = correction.status
        dateLabel.text = "Исправления внесены \(dateText). \(status.text)."
        statusImageView.image = status.image
        
        let likeText = " \(correction.likeCount)"
        likeButton.setTitle(likeText, for: .normal)
        likeButton.setTitle(likeText, for: .selected)
        
        selfLikeButton.setTitle(likeText, for: .normal)
        
        let dislikeText = " \(correction.dislikeCount)"
        dislikeButton.setTitle(dislikeText, for: .normal)
        dislikeButton.setTitle(dislikeText, for: .selected)
        selfDislikeButton.setTitle(dislikeText, for: .normal)
        
        let isLiked = service.wasLiked(id: correction.id)
        let isDisliked = service.wasUnliked(id: correction.id)
        
        likeButton.isSelected = isLiked
        dislikeButton.isSelected = isDisliked
        
        let isCurrentUser = self.isCurrentUser
        likesContainer.isHiddenInStackView = isCurrentUser
        selfLikeContainer.isHiddenInStackView = !isCurrentUser
        
        if correction.status != .inProgress {
            likesContainer.isHiddenInStackView = true
            selfLikeContainer.isHiddenInStackView = true
        }
        
        let isStatusMode = correction.isStatusMode
        typesContainer.isHiddenInStackView = isStatusMode
        statusContainer.isHidden = !isStatusMode
        
        if let status = correction.changeTo.status {
            configureStatus(
                imageView: fromStatusImageView,
                label: fromStatusLabel,
                status: point?.status ?? .open
            )
            
            configureStatus(
                imageView: toStatusImageView,
                label: toStatusLabel,
                status: status
            )
        }
        
        if let toTypes = correction.changeTo.types,
           let fromTypes = point?.wasteTypes {
            let fromCellModels = fromTypes.map {
                WasteTypeCellModel(
                    waste: $0,
                    isSelected: false,
                    mode: .readOnly
                )
            }
            
            let toCellModels = toTypes.map {
                WasteTypeCellModel(
                    waste: $0,
                    isSelected: false,
                    mode: .readOnly
                )
            }
            
            fromWasteTypesView.configure(with: fromCellModels)
            toWasteTypesView.configure(with: toCellModels)
        }
    }
    
    @IBAction func likeTapped(_ sender: UIButton) {
        guard !sender.isSelected else {
            unlike()
            return
        }
        
        service.set(isLiked: 1, for: correction.id) { [weak self] result in
            switch result {
            case .success:
                self?.correction.likeCount += 1
                self?.configure()
                self?.reloadCorrection()
            case .failure:
                break
            }
        }
    }
    
    @IBAction func dislikeTapped(_ sender: UIButton) {
        guard !sender.isSelected else {
            unlike()
            return
        }
        
        service.set(isLiked: -1, for: correction.id) { [weak self] result in
            switch result {
            case .success:
                self?.correction.dislikeCount += 1
                self?.configure()
                self?.reloadCorrection()
            case .failure:
                break
            }
        }
    }
    
    func unlike() {
        service.set(isLiked: 0, for: correction.id) { [weak self] result in
            switch result {
            case .success:
                self?.reloadCorrection()
            case .failure:
                break
            }
        }
    }
    
    func configureStatus(imageView: UIImageView, label: UILabel, status: RecyclePointStatus) {
        let statusViewModel = StatusViewModel(status: status)
        imageView.image = statusViewModel.image
        imageView.backgroundColor = statusViewModel.color
        label.text = statusViewModel.text
        label.textColor = statusViewModel.color
    }
    
    var isCurrentUser: Bool {
        let all = userService.user?.correctionIds.all ?? []
        return all.contains(correction.id)
    }
    
    func reloadCorrection() {
        service.loadCorrections(ids: [correction.id]) { [weak self] result in
            if let value = result.value?.first {
                self?.correction = value
                self?.configure()
            }
        }
    }
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.M.yyyy в HH:mm"
        return formatter
    }()
}
