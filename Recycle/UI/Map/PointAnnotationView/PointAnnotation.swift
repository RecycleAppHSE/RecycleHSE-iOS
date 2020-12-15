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
    let partlyFilter: Bool
    
    // MARK: - Init
    
    init(point: RecyclePoint, filterTypes: [WasteType], partlyFilter: Bool = false) {
        id = point.id
        self.partlyFilter = partlyFilter
        let types = point.wasteTypes.filter { !$0.isUnknown }
        wasteImages = types.map {
            let image = WasteTypeModel(type: $0).image
            let isSelected = filterTypes.contains($0)
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
