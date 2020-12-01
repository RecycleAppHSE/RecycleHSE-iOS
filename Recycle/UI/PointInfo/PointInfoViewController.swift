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
    
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var correctionsButton: UIButton!
    
    
    @Inject var appHelper: AppHelper
    @Inject var geocoder: CLGeocoder
    
    var point: RecyclePoint!
    var filterTypes: [WasteType] = []
    weak var delegate: PointUpdaterDelegate?
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    // MARK: - Actions
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func phoneTapped(_ sender: UIButton) {
        appHelper.call(to: point.phoneNumber)
    }
    
    @IBAction func emailTapped(_ sender: UIButton) {
        appHelper.sendEmail(to: sender.currentTitle)
    }
    
    @IBAction func linkTapped(_ sender: UIButton) {
        appHelper.open(url: point.webSite)
    }
    
    @IBAction func correctionTapped(_ sender: UIButton) {
        let vc: CorrectionModeViewController = create()
        vc.point = point
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
}

extension PointInfoViewController {
    
    func loadTitle() {
        organizationLabel.text = point.name
        
//        if let address = point.address {
//            titleLabel.text = address
//        } else {
            loadAddress()
//        }
    }
    
    func configureWasteTypes() {
        let cellModels: [WasteTypeCellModel] = point.wasteTypes.map {
            WasteTypeCellModel(
                waste: $0,
                isSelected: filterTypes.contains($0), mode: .readOnly
            )
        }

        wasteTypesView.configure(with: cellModels)
    }
    
    func configureTexts() {
        organizationLabel.text = point.name
        
        let statusViewModel = StatusViewModel(status: point.status)
        statusImageView.image = statusViewModel.image
        statusImageView.backgroundColor = statusViewModel.color
        statusLabel.text = statusViewModel.text
        statusLabel.textColor = statusViewModel.color
        
        let phone = point.phoneNumber
        phoneButton.setTitle(phone, for: .normal)
        
        let link = point.webSite?.absoluteString
        websiteButton.setTitle(link, for: .normal)
        
        emailButton.setTitle("test@email.ru", for: .normal)
        
        for button in [phoneButton, websiteButton, emailButton] {
            if button?.currentTitle == nil {
                button?.isEnabled = false
                button?.setTitle("Нет", for: .normal)
            }
        }
        
        let correctionsTitle = "История исправлений (\(point.correctionsCount) актуальных)"
        correctionsButton.setTitle(correctionsTitle, for: .normal)
    }
}

extension PointInfoViewController: PointUpdaterDelegate {
    
    func didUpdatePoint(_ point: RecyclePoint) {
        self.point = point
        configureViews()
        
        delegate?.didUpdatePoint(point)
    }
}

private extension PointInfoViewController {
    
    func configureViews() {
        loadTitle()
        configureWasteTypes()
        configureTexts()
    }
    
    func loadAddress() {
        let location = CLLocation(
            latitude: point.latitude,
            longitude: point.longitude
        )

        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first else { return }

            let street = placemark.thoroughfare ?? ""
            let house = placemark.subThoroughfare ?? ""

            self?.titleLabel.text = "\(street) \(house)"
        }
    }
}
