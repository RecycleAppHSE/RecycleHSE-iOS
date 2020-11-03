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
        
        let cellModels: [WasteTypeCellModel] = point.wasteTypes.map {
            .init(wasteType: $0)
        }

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
        
        // 55.806085, 37.559281
        let location1 = CLLocation(latitude: 55.806085, longitude: 37.559281)
        geocoder.reverseGeocodeLocation(location1) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first else { return }
            
            let country = placemark.country ?? ""
            let city = placemark.locality ?? ""
            let street = placemark.thoroughfare ?? ""
            let house = placemark.subThoroughfare ?? ""
            
            self?.titleLabel.text = "\(country) \(city) \(street) \(house)"
        }
    }
}
