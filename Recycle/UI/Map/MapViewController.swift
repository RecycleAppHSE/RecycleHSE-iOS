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
    
    let annotationId = MKMapViewDefaultAnnotationViewReuseIdentifier
    let clusterId = String(describing: PointClusterView.self)
    //let clusterId = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
        
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
        
        switch annotation {
        case let pointAnnotation as PointAnnotation:
            
            let view = PointAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            view.calloutView.delegate = self
            view.calloutView.annotation = pointAnnotation
            return view
        case is MKClusterAnnotation:
            return mapView.dequeueReusableAnnotationView(withIdentifier: clusterId)
        default:
            return nil
        }
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
        
        let vc: PointInfoViewController = create()
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
        
        mapView.register(PointClusterView.self, forAnnotationViewWithReuseIdentifier: clusterId)
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestAuth()
    }
    
    func loadPoints() {
        pointService.loadPoints { [weak self] result in
            
            switch result {
            case .success(let points):
                self?.handle(points: points)
            case .failure(let error):
                break
            }
        }
    }
    
    func handle(points: [RecyclePoint]) {
        let annotations = points.prefix(5000).map {
            PointAnnotation(point: $0)
        }
        
        mapView.addAnnotations(annotations)
        
//        let queue = DispatchQueue.global(qos: .userInteractive)
//        queue.async { [weak self] in
//
//        }
    }
}
