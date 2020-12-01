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
    weak var delegate: PointUpdaterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    @IBAction func showWasteTypesEdit(_ sender: UIButton) {
        let vc: WasteTypeCorrectionViewController = create()
        vc.point = point
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showStatusEdit(_ sender: UIButton) {
        let vc: StatusCorrectionViewController = create()
        vc.point = point
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension CorrectionModeViewController: PointUpdaterDelegate {
    
    func didUpdatePoint(_ point: RecyclePoint) {
        self.point = point
        configureViews()
        
        delegate?.didUpdatePoint(point)
    }
}

private extension CorrectionModeViewController {
    
    func configureViews() {
        configureWasteTypes()
        configureStatus()
    }
    
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
