//
//  StatusCorrectionViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 01.12.2020.
//

import UIKit

final class StatusCorrectionViewController: UIViewController {
    
    @Inject var service: CorrectionService
    var point: RecyclePoint = .empty
    weak var delegate: PointUpdaterDelegate?
    
    @IBOutlet var buttons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let index: Int
        switch point.status {
        case .open:
            index = 0
        case .broken:
            index = 1
        case .closed:
            index = 2
        }
        buttonSelected(buttons[index])
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        buttons.forEach {
            $0.isSelected = false
        }
        
        sender.isSelected = true
    }
    
    @IBAction func suggestCorrectionTapped(_ sender: UIButton) {
        var point = self.point
        
        service.suggestCorrection(id: point.id, status: newStatus) { [weak self] (result) in
            switch result {
            case .success(let id):
                point.status = status
                point.correctionsCount += 1
                self?.delegate?.didUpdatePoint(point)
                self?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
    
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


private extension StatusCorrectionViewController {
    
    var newStatus: RecyclePointStatus {
        if buttons[0].isSelected {
            return .open
        } else if buttons[1].isSelected {
            return .broken
        } else {
            return .closed
        }
    }
    
    func reloadButton() {
        
    }
}
