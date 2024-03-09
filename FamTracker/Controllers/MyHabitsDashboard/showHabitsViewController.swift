//
//  showHabitsViewController.swift
//  FamTracker
//
//  Created by Riyasat  on 19/05/22.
//

import UIKit
import MapKit

class showHabitsViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var habitName: UILabel!
    
    @IBOutlet weak var repeatTime: UILabel!
    
    @IBOutlet weak var goal: UILabel!
    
    @IBOutlet weak var reminder: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var timeOfDay: UILabel!
    
    @IBOutlet weak var startDate: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    let annotation = MKPointAnnotation()
    var habitsData : Habits!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = UIImage(data: habitsData.icon!)
        habitName.text = habitsData.habitName
        repeatTime.text = habitsData.reapetTime
        goal.text = habitsData.goal
        reminder.text = habitsData.reminderTime
        location.text = habitsData.location
        timeOfDay.text = habitsData.timeOfDay
        startDate.text = habitsData.startDate
        let lat = habitsData.lat
        let long = habitsData.long
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.mapView.addAnnotation(annotation)
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    
    }
    
    @IBAction func dimiss(_ sender: Any) {
        dismiss(animated: true)
    }

}
