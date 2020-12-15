//
//  TipPageViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 15.12.2020.
//

import UIKit

class TipPageViewController: UIViewController {
    
    var tip: Tip?
    var header: String = ""
    var page: Int = 0
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id = tip?.id ?? 0
        imageView.image = UIImage(named: "tips\(id % 2)")
        
        headerLabel.text = header
        nameLabel.text = tip?.title
        contentLabel.text = tip?.content
    }
}
