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
    
    @Inject var locationManager: LocationManager
    @Inject var userService: UserService
    @Inject var pointService: PointService
    
    let annotationId = "point_annotation_identifier"
    var points: [RecyclePoint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUserIfNeeded()
        
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
        let annotation = annotation as? PointAnnotation
        let id = annotation?.id ?? 0
        guard let point = pointService.point(with: id) else {
            return
        }
        
        let vc = PointInfoViewController()
        vc.point = point
        present(vc, animated: true)
    }
}

private extension MapViewController {
    
    func createUserIfNeeded() {
        userService.createUserIfNeeded { [weak self] result in
            switch result {
            case .success:
                self?.loadPoints()
            case .failure(let error):
                break
                // TODO: showError
            }
        }
    }
    
    func setupMap() {
        mapView.delegate = self
        
        mapView.register(PointAnnotationView.self, forAnnotationViewWithReuseIdentifier: annotationId)
        
        
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestAuth()
    }
    
    func loadPoints() {
        pointService.loadPoints { [weak self] result in
            switch result {
            case .success(let points):
                let annotations = points.map {
                    PointAnnotation(point: $0)
                }
                self?.mapView.addAnnotations(annotations)
                
            case .failure(let error):
                break
            }
        }
    }
}
