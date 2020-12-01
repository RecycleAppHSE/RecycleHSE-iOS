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
    
    @Inject var userService: UserService
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUser()
    }
    
    // MARK: - Actions
    
    
}

extension ProfileViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n", currentName.contains("\n")  {
            textView.resignFirstResponder()
            userService.updateName(currentName) { [weak self] result in
                switch result {
                case .success:
                    return
                case .failure(let error):
                    self?.show(error: error)
                }
            }
        }
        
        return true
    }
}

private extension ProfileViewController {
    
    var currentName: String {
        nameTextView.text
    }
    
    func setupView() {
        nameTextView.delegate = self
        nameTextView.returnKeyType = .done
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        
        notConfirmedButton.title = "Не подтверждены"
        confirmedButton.title = "Подтверждены"
        allButton.title = "Все"
    }
    
    func loadUser() {
        userService.getUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.display(user: user)
            case .failure(let error):
                self?.show(error: error, repeatCallback: {
                    self?.loadUser()
                })
            }
        }
    }
    
    func display(user: User) {
        nameTextView.text = user.name
        
        let ids = user.correctionIds
        confirmedButton.count = ids.appliedCount
        notConfirmedButton.count = ids.inProgressCount
        allButton.count = ids.totalCount
    }
}
