//
//  PointInfoViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit
import CoreLocation

class PointInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusLastUpdateLabel: UILabel!
    
    @IBOutlet weak var wasteTypesView: WasteTypesView!
    
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geocoder.reverseGeocodeLocation(<#T##location: CLLocation##CLLocation#>, completionHandler: <#T##CLGeocodeCompletionHandler##CLGeocodeCompletionHandler##([CLPlacemark]?, Error?) -> Void#>)
        
        let cellModels: [WasteTypeCellModel] = [
            .init(waste: .glass,
                  isSelected: true,
                  mode: .readOnly),
            
            .init(waste: .clothes,
                  isSelected: false,
                  mode: .readOnly),
            
            .init(waste: .lamps,
                  isSelected: true,
                  mode: .readOnly),
            
            .init(waste: .metal,
                  isSelected: true,
                  mode: .readOnly),
            
            .init(waste: .paper,
                  isSelected: false,
                  mode: .readOnly),
            
            .init(waste: .plastic,
                  isSelected: true,
                  mode: .readOnly)
        ]

        wasteTypesView.configure(with: cellModels)
    }
    
    // MARK: - Actions
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
