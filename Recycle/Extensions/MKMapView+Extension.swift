//
//  MKMapView+Extension.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import MapKit

extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 10000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
    
    func zoomMap(byFactor delta: Double) {
        var span: MKCoordinateSpan = region.span
        span.latitudeDelta *= delta
        span.longitudeDelta *= delta
        region.span = span
        setRegion(region, animated: true)
    }
}
