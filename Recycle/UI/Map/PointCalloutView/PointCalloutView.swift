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

class PointCalloutView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: PointCalloutViewDelegate?
    
    var annotation: MKAnnotation?
    
    @IBOutlet private weak var contentView: UIView!
    
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
    
    // MARK: - Private functions
    
    private func initXib() {
        let typeDescribing = type(of: self)
        let nibName = String(describing: typeDescribing)
        let bundle = Bundle(for: typeDescribing)
        let nib = UINib(nibName: nibName, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        addContentViewConstraints()
    }
    
    private func addContentViewConstraints() {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func resetImages() {
        let views = wasteStackView.arrangedSubviews
        for view in views {
            view.removeFromSuperview()
        }
    }
}
