//
//  PointFilter.swift
//  Recycle
//
//  Created by Babaev Mikhail on 01.12.2020.
//

import UIKit

protocol PointFilterDelegate: AnyObject {
    var filterTypes: [WasteType] { get set }
}

class PointFilterViewController: UIViewController {
    
    @IBOutlet weak var wasteTypesView: WasteTypesView!
    weak var delegate: PointFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selected = delegate?.filterTypes ?? []
        let cellModels = WasteType.allCases.map {
            WasteTypeCellModel(
                waste: $0,
                isSelected: selected.contains($0),
                mode: .selectable
            )
        }
        
        wasteTypesView.configure(with: cellModels)
        wasteTypesView.selectedTypes = selected
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        delegate?.filterTypes = wasteTypesView.selectedTypes
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        delegate?.filterTypes = []
        dismiss(animated: true, completion: nil)
    }
    
}

