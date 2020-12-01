//
//  PointAnnotation.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import MapKit

struct WasteImageModel {
    let image: UIImage
    let backgroundColor: UIColor?
}

class PointAnnotation: NSObject, MKAnnotation {
    
    // MARK: - Properties
    
    let id: Int
    let coordinate: CLLocationCoordinate2D
    
    let wasteImages: [WasteImageModel]
    
    // MARK: - Init
    
    init(point: RecyclePoint, filterTypes: [WasteType]) {
        id = point.id
        wasteImages = point.wasteTypes.map {
            let image = WasteTypeModel(type: $0).image
            let isSelected = filterTypes.contains($0)
            if isSelected {
                print("selected")
            }
            return WasteImageModel(
                image: image,
                backgroundColor: isSelected ? .main : .clear
                
            )
        }
        
        coordinate = CLLocationCoordinate2D(
            latitude: point.latitude,
            longitude: point.longitude
        )
    }
}
