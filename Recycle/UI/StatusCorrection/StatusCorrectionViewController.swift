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
        
        switch point.status {
        case .open:
            buttons[0].isSelected = true
        case .broken:
            buttons[1].isSelected = true
        case .closed:
            buttons[2].isSelected = true
        }
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        buttons.forEach {
            $0.isSelected = false
        }
        
        sender.isSelected = true
    }
    
    @IBAction func suggestCorrectionTapped(_ sender: UIButton) {
        let status = self.status(tag: sender.tag)
        var point = self.point
        
        service.suggestCorrection(id: point.id, status: status) { [weak self] (result) in
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
}


private extension StatusCorrectionViewController {
    
    func status(tag: Int) -> RecyclePointStatus {
        switch tag {
        case 0:
            return .open
        case 1:
            return .broken
        default:
            return .closed
        }
    }
    
    func reloadButton() {
        
    }
}
