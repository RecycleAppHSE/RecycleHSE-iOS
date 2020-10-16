//
//  BubleButton.swift
//  Recycle
//
//  Created by Babaev Mikhail on 16.10.2020.
//

import UIKit

final class BubbleButton: UIView, XibLoadable {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!
    
    var tapAction: (() -> Void)?
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initXib()
    }
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 20
    }
    
    @IBAction func bubbleTapped(_ sender: UIButton) {
        tapAction?()
    }
}
