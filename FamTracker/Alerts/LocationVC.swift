//
//  LocationVC.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit
import MapKit
import CoreLocation

class LocationVC: UIViewController  {
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapView: UIView!
    let annotation = MKPointAnnotation()
    var localAddress = String()
    var letitute = Double()
    var long = Double()
    var currentLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        FamTracker.locationManager.delegate = self
        mapView.layer.cornerRadius = 20
        map.layer.cornerRadius = 20
        map.delegate = self
        getCurrentCoordinates()
        // Do any additional setup after loading the view.
    }
    
    func getCurrentCoordinates(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways{
            currentLocation = FamTracker.locationManager.location
            let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.map.setRegion(region, animated: true)
            annotation.coordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            letitute = currentLocation.coordinate.latitude
            long = currentLocation.coordinate.longitude
            getAddressFromLatLon(pdblLatitude: String(currentLocation.coordinate.latitude), withLongitude: String(currentLocation.coordinate.longitude))
            self.map.addAnnotation(annotation)
        }
    }
    
    @IBAction func doenBtn(_ sender: Any) {
        let userInfo = ["Address" : localAddress, "lati" : letitute, "long" : long] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "location"), object: nil, userInfo: userInfo)
        dismiss(animated: true)
    }
    
}

extension LocationVC: MKMapViewDelegate, CLLocationManagerDelegate {
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                
                self.localAddress = addressString
                print(addressString)
            }
        })
        
    }
    
}
