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
    
    var geocoder = CLGeocoder()
    
    var point: RecyclePoint!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTitle()
        
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

extension PointInfoViewController {
    
    func loadTitle() {
        let location = CLLocation(latitude: point.latitude, longitude: point.longitude)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            let placemark = placemarks?.first
            
            self?.titleLabel.text = placemark?.name
        }
    }
}
