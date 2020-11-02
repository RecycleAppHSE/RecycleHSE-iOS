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

    // MARK: Initialization
    
    override var annotation: MKAnnotation? {
        didSet {
            configureDetailView()
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        setupCircleView()
        
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setupCircleView() {
        backgroundColor = .clear

        let circleView = UIView()
        circleView.backgroundColor = .main
        circleView.layer.cornerRadius = 7
        circleView.clipsToBounds = true
        addSubview(circleView)

        circleView.frame = CGRect(x: 7, y: 7, width: 14, height: 14)
    }
}

private extension PointAnnotationView {
    
    func configureDetailView() {
        canShowCallout = true
        
        guard let annotation = annotation as? PointAnnotation else { return }
        
        calloutView.configure(
            images: annotation.wasteImages
        )
        detailCalloutAccessoryView = calloutView
        
        let button = UIButton(type: .detailDisclosure)
        button.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
        button.tintColor = .black
        button.frame = .init(x: 0, y: 0, width: 20, height: 20)
        rightCalloutAccessoryView = button
    }
}
