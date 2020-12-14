//
//  WasteTypeCell.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit

class WasteTypeCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 12
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.1
    }
    
    func configure(with cellModel: WasteTypeCellModel) {
        
        textLabel.text = cellModel.title
        textLabel.textColor = cellModel.titleColor
        imageView.image = cellModel.image
        
        tickImageView.image = cellModel.tickImage
        tickImageView.isHidden = cellModel.hideTick
        
        containerView.backgroundColor = cellModel.backgroundColor
    }
}
