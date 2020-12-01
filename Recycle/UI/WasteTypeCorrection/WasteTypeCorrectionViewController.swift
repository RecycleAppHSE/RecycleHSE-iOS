//
//  WasteTypeCorrectionViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 30.11.2020.
//

import UIKit

final class WasteTypeCorrectionViewController: UIViewController {
    
    var point: RecyclePoint = .empty
    
    @Inject var service: CorrectionService
    weak var delegate: PointUpdaterDelegate?

    @IBOutlet weak var wasteTypesView: WasteTypesView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellModels = WasteType.allCases.map {
            WasteTypeCellModel(
                waste: $0,
                isSelected: point.wasteTypes.contains($0),
                mode: .selectableBlue
            )
        }
        wasteTypesView.configure(with: cellModels)
        wasteTypesView.selectedTypes = point.wasteTypes
    }
    
    @IBAction func correctTapped(_ sender: UIButton) {
        let types = wasteTypesView.selectedTypes
        let id = point.id
        var point = self.point
        
        service.suggestCorrection(id: id, types: types) { [weak self] result in
            switch result {
            case .success(let id):
                point.correctionsCount += 1
                self?.delegate?.didUpdatePoint(point)
                
                self?.dismiss(animated: true, completion: {
                    // show success
                })
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
    
    
    @IBAction func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}
