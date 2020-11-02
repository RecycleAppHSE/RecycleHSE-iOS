//
//  ProfileViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 16.10.2020.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextView: UITextView!
    
    @IBOutlet weak var notConfirmedButton: BubbleButton!
    @IBOutlet weak var confirmedButton: BubbleButton!
    @IBOutlet weak var allButton: BubbleButton!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        
        notConfirmedButton.title = "Не подтверждены"
        confirmedButton.title = "Подтверждены"
        allButton.title = "Все"
    }
    
    // MARK: - Actions
    
    
}
