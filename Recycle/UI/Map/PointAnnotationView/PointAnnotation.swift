//
//  PointAnnotation.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import MapKit

class PointAnnotation: NSObject, MKAnnotation {
    
    // MARK: - Properties
    
    let id: String
    let coordinate: CLLocationCoordinate2D
    
    let wasteImages: [UIImage]
    
    // MARK: - Init
    
    init(point: RecyclePoint) {
        id = point.id
        
        wasteImages = point.wasteTypes.map {
            WasteTypeModel(type: $0).image
        }
        
        coordinate = CLLocationCoordinate2D(
            latitude: point.latitude,
            longitude: point.longitude
        )
    }
}
