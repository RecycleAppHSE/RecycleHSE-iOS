//
//  MapViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager: LocationManager = LocationManagerImp()
    
    let annotationId = "point_annotation_identifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocation()
        setupMap()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let pointAnnotation = annotation as? PointAnnotation else {
            return nil
        }
        
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? PointAnnotationView
        
        view?.calloutView.delegate = self
        view?.calloutView.annotation = pointAnnotation
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        didSelectCallout(with: view.annotation)
    }
}

extension MapViewController: LocationManagerDelegate {
    
    func didUpdateLocation(_ location: CLLocation) {
        // TODO: set user location
    }
}

extension MapViewController: PointCalloutViewDelegate {
    
    func didSelectCallout(with annotation: MKAnnotation?) {
        performSegue(withIdentifier: "pointInfo", sender: self)
    }
}

private extension MapViewController {
    
    func setupMap() {
        mapView.delegate = self
        
        mapView.register(PointAnnotationView.self, forAnnotationViewWithReuseIdentifier: annotationId)
        
        mapView.addAnnotations(PointAnnotation.test)
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestAuth()
    }
}
