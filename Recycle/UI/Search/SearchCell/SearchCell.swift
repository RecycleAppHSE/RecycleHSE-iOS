//
//  SearchTableViewCell.swift
//  Recycle
//
//  Created by Babaev Mikhail on 16.11.2020.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func configure(title: String, text: String?) {
        titleNameLabel.text = text
        addressLabel.text = title
    }
}

