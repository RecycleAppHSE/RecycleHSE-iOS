//
//  MapViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @Inject var locationManager: LocationManager
    @Inject var userService: UserService
    @Inject var pointService: PointService
    
    let annotationId = MKMapViewDefaultAnnotationViewReuseIdentifier
    let clusterId = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
        
    var points: [RecyclePoint] = []
    
    var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUserIfNeeded()
        
        setupSearch()
        setupLocation()
        setupMap()
    }
    
    // MARK: - Actions
    
    @IBAction func zoomInTapped(_ sender: UIButton) {
        mapView.zoomMap(byFactor: 0.5)
    }
    
    @IBAction func zoomOutTapped(_ sender: Any) {
        mapView.zoomMap(byFactor: 2.0)
    }
    
    @IBAction func userLocationTapped(_ sender: Any) {
        guard let location = locationManager.location else { return }
        mapView.centerToLocation(location)
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        // TODO: present filter screen
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        switch annotation {
        case let pointAnnotation as PointAnnotation:
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as! PointAnnotationView
            view.annotation = pointAnnotation
            view.clusteringIdentifier = clusterId
            view.calloutView.delegate = self
            view.calloutView.annotation = pointAnnotation
            return view
            
        case is MKClusterAnnotation:
            let clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: clusterId)
            clusterView?.annotation = annotation
            return clusterView
            
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
        // TODO: move pin
    }
}

extension MapViewController: PointCalloutViewDelegate {
    
    func didSelectCallout(with annotation: MKAnnotation?) {
        let annotation = annotation as? PointAnnotation
        let id = annotation?.id ?? 0
        guard let point = pointService.point(with: id) else {
            return
        }
        
        showPointInfo(point: point)
    }
}

extension MapViewController: SearchPointDelegate {
    
    func didSelectPoint(_ point: RecyclePoint) {
        showPointInfo(point: point)
    }
}

private extension MapViewController {
    
    func createUserIfNeeded() {
        userService.createUserIfNeeded { [weak self] result in
            switch result {
            case .success:
                self?.loadPoints()
            case .failure(let error):
                self?.show(error: error) { [weak self] in
                    self?.createUserIfNeeded()
                }
            }
        }
    }
    
    func setupMap() {
        mapView.delegate = self
        
        mapView.register(PointAnnotationView.self, forAnnotationViewWithReuseIdentifier: annotationId)
        
        mapView.register(PointClusterView.self, forAnnotationViewWithReuseIdentifier: clusterId)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 40000)
        mapView.setCameraZoomRange(zoomRange, animated: false)
        
        let moscow = CLLocation(latitude: 55.7558, longitude: 37.6173)
        mapView.centerToLocation(moscow)
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
                self?.show(error: error, repeatCallback: {
                    self?.loadPoints()
                })
            }
        }
    }
    
    func handle(points: [RecyclePoint]) {
        let annotations = points.prefix(5000).map {
            PointAnnotation(point: $0)
        }
//        let annotations = points.map {
//            PointAnnotation(point: $0)
//        }
        
        mapView.addAnnotations(annotations)
    }
    
    func setupSearch() {
        let resultsController = SearchPointController()
        
        let searchController = UISearchController(
            searchResultsController: resultsController
        )
        searchController.searchResultsUpdater = resultsController
        searchController.searchBar.placeholder = "Поиск места или адреса"
        searchController.searchBar.setValue("Отменить", forKey: "cancelButtonText")
        searchController.searchBar.tintColor = .main
        
        resultsController.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    func showPointInfo(point: RecyclePoint) {
        let vc: PointInfoViewController = create()
        vc.point = point
        present(vc, animated: true)
    }
}
