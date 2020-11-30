//
//  CorrectionModeViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 30.11.2020.
//

import UIKit

class CorrectionModeViewController: UIViewController {
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var wasteTypesView: WasteTypesView!
    
    var point: RecyclePoint = .empty
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureWasteTypes()
        configureStatus()
    }
    
    @IBAction func showWasteTypesEdit(_ sender: UIButton) {
        let vc: WasteTypeCorrectionViewController = create()
        vc.point = point
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showStatusEdit(_ sender: UIButton) {
        
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

private extension CorrectionModeViewController {
    
    func configureWasteTypes() {
        let cellModels: [WasteTypeCellModel] = point.wasteTypes.map {
            .init(wasteType: $0, hideTitle: false)
        }

        wasteTypesView.configure(with: cellModels)
    }
    
    func configureStatus() {
        let statusViewModel = StatusViewModel(status: point.status)
        statusImageView.image = statusViewModel.image
        statusImageView.backgroundColor = statusViewModel.color
        statusLabel.text = statusViewModel.text
        statusLabel.textColor = statusViewModel.color
    }
}
