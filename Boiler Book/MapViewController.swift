//
//  MapViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 4/28/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    

    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManger.requestWhenInUseAuthorization()
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.distanceFilter = kCLDistanceFilterNone
        locationManger.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 40.4237, longitude: -86.9212)
        mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 9000), animated: false)
        mapView.delegate = self
        let randomLoc = MyAnnotation(coordinate:  CLLocationCoordinate2D(latitude: 40.4237, longitude: -86.9212), title: "Purdue University", subtitle: "West Lafayette Campus")
        
        let loc1 = MKMapPoint(CLLocationCoordinate2D(latitude: 40.4237, longitude: -86.9212))
        let loc2 = MKMapPoint(CLLocationCoordinate2D(latitude: 40.4237, longitude: 86.9212))
        print(loc1.distance(to: loc2))
        
        mapView.addAnnotation(randomLoc)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation as? MyAnnotation == nil {
            return nil
        }
        let pinIdentifier = "PinAnnotaiton"
        var pin: MKPinAnnotationView?
        pin = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdentifier) as? MKPinAnnotationView
        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
        }
        pin?.annotation = annotation
        pin?.canShowCallout = true
        pin?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin
    }
}

class MyAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
}
