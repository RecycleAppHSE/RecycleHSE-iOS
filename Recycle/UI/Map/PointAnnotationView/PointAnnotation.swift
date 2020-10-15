//
//  PointAnnotation.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import MapKit

class PointAnnotation: NSObject, MKAnnotation {
    
    // MARK: - Properties
    
    var coordinate: CLLocationCoordinate2D
    
    var wasteImages: [UIImage] {
        [
            WasteTypeModel(type: .clothes).image,
            WasteTypeModel(type: .lamps).image,
            WasteTypeModel(type: .plastic).image,
        ]
    }
    
    // MARK: - Init
    
    init(longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        coordinate = .init(latitude: latitude, longitude: longitude)
    }
    
    static var test: [PointAnnotation] {
        return [
            PointAnnotation(longitude: 55.7558, latitude: 37.6173),
            PointAnnotation(longitude: 3.7558, latitude: 37.6173),
            PointAnnotation(longitude: 55.7558, latitude: 50.6173)
        ]
    }
}
