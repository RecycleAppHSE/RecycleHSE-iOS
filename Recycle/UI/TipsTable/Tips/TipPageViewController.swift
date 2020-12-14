//
//  TipPageViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 15.12.2020.
//

import UIKit

class TipPageViewController: UIViewController {
    
    var tip: Tip!
    var page: Int = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "tips\(tip.id % 2)")
        
        nameLabel.text = tip.title
        contentLabel.text = tip.content
        
        
    }
}
