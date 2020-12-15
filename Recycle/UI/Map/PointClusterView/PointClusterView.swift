//
//  PointClusterView.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation
import MapKit

final class PointClusterView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? MKClusterAnnotation else {
            return
        }
        
        let count = annotation.memberAnnotations.count
        image = self.image(annotation: annotation, count: count)
    }
    
    func image(annotation: MKClusterAnnotation, count: Int) -> UIImage? {
        let hasPartlyFilter = self.hasPartlyFilter(annotation)
        let backgroundColor: UIColor = hasPartlyFilter ? .white : .main
        let textColor: UIColor = hasPartlyFilter ? .main : .white
        
        layer.cornerRadius = 20
        layer.borderColor = textColor.cgColor
        
        if hasPartlyFilter {
            layer.borderWidth = 5
        } else {
            layer.borderWidth = 0
        }
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40.0, height: 40.0))
        image = renderer.image { _ in
            backgroundColor.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)).fill()
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)
            ]

            let text = "\(count)"
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
        
        return image
    }
    
    private func hasPartlyFilter(_ clusterAnnotation: MKClusterAnnotation) -> Bool {
        for annotation in clusterAnnotation.memberAnnotations {
            let pointAnnotation = annotation as? PointAnnotation
            if pointAnnotation?.partlyFilter == true {
                return true
            }
        }
        
        return false
    }
}
