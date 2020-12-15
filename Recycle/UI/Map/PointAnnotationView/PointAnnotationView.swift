//
//  PointAnnotationView.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit
import MapKit

final class PointAnnotationView: MKAnnotationView {
    
    let calloutView = PointCalloutView()
    let circleView = UIView()

    // MARK: Initialization

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        setupCircleView()
        
        let button = UIButton(type: .detailDisclosure)
        button.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
        button.tintColor = .black
        button.frame = .init(x: 0, y: 0, width: 30, height: 30)
        rightCalloutAccessoryView = button
        
        canShowCallout = true
        detailCalloutAccessoryView = calloutView
        
        displayPriority = .defaultLow
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        configure()
    }

    // MARK: Setup

    private func setupCircleView() {
        
        backgroundColor = .clear

        let size: CGFloat = 20
        let origin = size / 2
        
        circleView.layer.cornerRadius = origin
        circleView.clipsToBounds = true
        
        addSubview(circleView)

        circleView.frame = CGRect(x: origin, y: origin, width: size, height: size)
    }
}

private extension PointAnnotationView {
    
    func configure() {
        guard let annotation = annotation as? PointAnnotation else { return }
        
        calloutView.configure(
            images: annotation.wasteImages
        )
        
        if annotation.partlyFilter {
            circleView.backgroundColor = .white
            circleView.layer.borderColor = UIColor.main?.cgColor
            circleView.layer.borderWidth = 5
        } else {
            circleView.backgroundColor = .main
            circleView.layer.borderColor = UIColor.clear.cgColor
            circleView.layer.borderWidth = 0
        }
    }
}
