//
//  TipsTableViewCell.swift
//  Recycle
//
//  Created by Babaev Mikhail on 15.12.2020.
//

import UIKit


class TipsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tipsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func configure(tips: TipsCollection) {
        tipsImageView.image = UIImage(named: "tipsCollection-\(tips.id)")
        
        nameLabel.text = tips.title
        countLabel.text = "\(tips.tipsNumber) советов"
    }
}
