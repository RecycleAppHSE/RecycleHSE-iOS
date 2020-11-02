//
//  PointCalloutView.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit
import MapKit

protocol PointCalloutViewDelegate: AnyObject {
    
    func didSelectCallout(with annotation: MKAnnotation?)
}

class PointCalloutView: UIView, XibLoadable {
    
    // MARK: - Properties
    
    weak var delegate: PointCalloutViewDelegate?
    
    var annotation: PointAnnotation?
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet private weak var wasteStackView: UIStackView!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initXib()
    }
    
    // MARK: - Functions
    
    func configure(images: [UIImage]) {
        resetImages()
    
        for image in images {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            wasteStackView.addArrangedSubview(imageView)
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.didSelectCallout(with: annotation)
    }
    
    private func resetImages() {
        let views = wasteStackView.arrangedSubviews
        for view in views {
            view.removeFromSuperview()
        }
    }
}
