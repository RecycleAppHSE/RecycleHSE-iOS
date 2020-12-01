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
    
    func configure(images: [WasteImageModel]) {
        resetImages()
    
        for imageModel in images {
            let imageView = UIImageView(image: imageModel.image)
            
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            imageView.layer.cornerRadius = 4
            imageView.clipsToBounds = true
            imageView.contentMode = .center
            imageView.backgroundColor = imageModel.backgroundColor
            
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
