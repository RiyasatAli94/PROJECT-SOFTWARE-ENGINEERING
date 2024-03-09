//
//  CreateYourOwnVC.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit
import DLLocalNotifications
import SwiftLocalNotification
import EventKit

class CreateYourOwnVC: UIViewController, UNUserNotificationCenterDelegate {

    static let shared = CreateYourOwnVC()
    //Top Bar
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtnO: UIButton!
    
    //titleBar
    @IBOutlet weak var titleIconView: UIView!
    @IBOutlet weak var titleIcon: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titletxt: UITextField!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var repeattxtLabel: UILabel!
    @IBOutlet weak var repeatview: UIView!
    @IBOutlet weak var goalLbl: UILabel!
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var everydayLbl: UILabel!
    @IBOutlet weak var everyiconLbl: UIView!
    
    @IBOutlet weak var TimeView: UIView!
    @IBOutlet weak var TimeiCONView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateICONView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationICONView: UIView!
    @IBOutlet weak var locationLbl: UILabel!
    
    var image = UIImage()
    var titles = String()
    
    var letitute = Double()
    var long = Double()
    var imgData = Data()
    var repeatTime = String()
    var goal = String()
    var timeofday = String()
    var remTime = String()
    var date = String()
    var location = String()
    var isEdit = Bool()
    var editableHabitData : Habits!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.layer.cornerRadius = 10
        titleIconView.layer.cornerRadius = 10
        mainView.layer.cornerRadius = 10
        TimeView.layer.cornerRadius = 10
        dateView.layer.cornerRadius = 10
        
        locationView.layer.cornerRadius = 10
        locationICONView.layer.cornerRadius = 10
        
        dateICONView.layer.cornerRadius = 5
        TimeiCONView.layer.cornerRadius = 5
        dateView.layer.cornerRadius = 5
        goalView.layer.cornerRadius = 5
        repeatview.layer.cornerRadius = 5
        titleIcon.image = image
        if let data = image.pngData(){
            imgData = data
        }
        titletxt.text = titles
        hideKeyboardWhenTappedAround()
        localNotificationScheduler = SwiftLocalNotification(delegate: self, notificationPermissionOptions: nil)
        if isEdit == true{
            titleIcon.image = UIImage(data: editableHabitData.icon ?? Data())
            image = UIImage(data: editableHabitData.icon ?? Data())!
            imgData = editableHabitData.icon!
            
            titletxt.text = Utils.unwarpString(string: editableHabitData.habitName)
            titles = Utils.unwarpString(string: editableHabitData.habitName)
            
            repeattxtLabel.text = Utils.unwarpString(string: editableHabitData.reapetTime)
            repeatTime = Utils.unwarpString(string: editableHabitData.reapetTime)
            
            goalLbl.text = Utils.unwarpString(string: editableHabitData.goal)
            goal = Utils.unwarpString(string: editableHabitData.goal)
            
            everydayLbl.text = Utils.unwarpString(string: editableHabitData.timeOfDay)
            remTime = Utils.unwarpString(string: editableHabitData.timeOfDay)
            
            timeLbl.text = Utils.unwarpString(string: editableHabitData.reminderTime)
            timeofday = Utils.unwarpString(string: editableHabitData.reminderTime)
            
            let startDate = Utils.unwarpString(string: editableHabitData.startDate)
            dateLbl.text = startDate
            date = startDate
            
            locationLbl.text = Utils.unwarpString(string: editableHabitData.location)
            location = Utils.unwarpString(string: editableHabitData.location)
            
            letitute = editableHabitData.lat
            long = editableHabitData.long
        }
        
    }
    
    @IBAction func repeatBrn(_ sender: Any) {
        let alert = dayPickerService.shared.alertPresent(isSelected: weekCheck, dataArray: WeekList)
        present(alert, animated: true)
    }
    
    @IBAction func goalBtn(_ sender: Any) {
        var unit = [String]()
        switch titles{
        case "Meditate","Read Books","Gym","Swimming","Yoga","Exercise","Create Your Own":
            unit = UnitType3
        case "Drink Water":
            unit = UnitType1
        default:
            unit = UnitType2
        }
        let alert = goalService.shared.alertPresent(unitType: unit)
        present(alert, animated: true)
    }
    
    @IBAction func everydayBtn(_ sender: Any) {
        let alert = dayPickerService.shared.alertPresent(isSelected: noonCheck, dataArray: NoonsList)
        present(alert, animated: true)
    }
    
    @IBAction func timeBtn(_ sender: Any) {
        let alert = dateTimeService.shared.alertPresent(isDate: false)
        present(alert, animated: true)
    }
    
    @IBAction func dateBtn(_ sender: Any) {
        let alert = dateTimeService.shared.alertPresent(isDate: true)
        present(alert, animated: true)
    }
    
    @IBAction func locationBtn(_ sender: Any) {
        let alert = mapAlertService.shared.alertPresent()
        present(alert, animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if isEdit == true{
            
            let id = Utils.unwarpString(string: editableHabitData.id)
            let userInfo = ["habitName" : Utils.unwarpString(string: titletxt.text), "repeat" : repeatTime, "goal" : goal, "timeofday" : timeofday, "rimDay" : remTime, "startDate" : Utils.unwarpString(string: dateLbl.text), "location" : location]
            habits.sharedInstance.updateHabit(id : id,img: imgData, lat: letitute, long: long, Dict: userInfo)
            ScreensManager.shared.dashboard(on: self, modal: true, animated: false)
        }else{
            let NSUUIDid = NSUUID().uuidString
            do{
                let userInfo = ["habitName" : Utils.unwarpString(string: titletxt.text), "repeat" : repeatTime, "goal" : goal, "timeofday" : timeofday, "rimDay" : remTime, "startDate" : date, "location" : location]
                try habits.sharedInstance.SaveHabit(img: imgData, lat: letitute, long: long, id: NSUUIDid, Dict: userInfo)
            }catch{
                print(error)
            }
            let dateSring = "\(Utils.unwarpString(string: date)) " + "\(Utils.unwarpString(string: remTime))"
            let convt = DateConverter.RemiderDate(date: dateSring)
            notifySwiftNotification(Title: "Your \(Utils.unwarpString(string: titletxt.text)) habit start now.", Body: " \(Utils.unwarpString(string: titletxt.text))", DateTime: convt, id : NSUUIDid)
            ScreensManager.shared.dashboard(on: self, modal: true, animated: false)
        }
    }
    
    @IBAction func canceBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.location(notify:)), name: NSNotification.Name("location"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getDate(notify:)), name: NSNotification.Name("getDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.getTime(notify:)), name: NSNotification.Name("getTime"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.weekList(notify:)), name: NSNotification.Name("weekList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.noonList(notify:)), name: NSNotification.Name("noonList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.goal(notify:)), name: NSNotification.Name("goal"), object: nil)
    }
    
    @objc func goal(notify : Notification){
        let userInfo = notify.userInfo!["data"] as? String
        goal = Utils.unwarpString(string: userInfo)
        goalLbl.text = Utils.unwarpString(string: userInfo)
    }
    
    @objc func location(notify : Notification){
        let userInfo = notify.userInfo!["Address"] as? String
        if let lat = notify.userInfo!["lati"] as? Double{
            letitute = lat
        }
        
        if let long1 = notify.userInfo!["long"] as? Double{
            long = long1
        }
        location = Utils.unwarpString(string: userInfo)
        locationLbl.text = Utils.unwarpString(string: userInfo)
    }
    
    @objc func getDate(notify : Notification){
        let userInfo = notify.userInfo!["date"] as? String
        date = Utils.unwarpString(string: userInfo)
        dateLbl.text = Utils.unwarpString(string: userInfo)
    }
    
    @objc func getTime(notify : Notification){
        let userInfo = notify.userInfo!["time"] as? String
        remTime = Utils.unwarpString(string: userInfo)
        timeLbl.text = Utils.unwarpString(string: userInfo)
    }
    
    @objc func noonList(notify : Notification){
        let userInfo = notify.userInfo!["data"] as? [String]
        var noonstring = String()
        if let data = userInfo{
            switch data.count{
            case 3:
                noonstring = "Any Time"
            case 2:
                noonstring = "\(data[0]), \(data[1])"
            case 1:
                noonstring = "\(data[0])"
            default:
                noonstring = "Any Time"
            }
        }
        timeofday = noonstring
        everydayLbl.text = noonstring
    }
    
    @objc func weekList(notify : Notification){
        let userInfo = notify.userInfo!["data"] as? [String]
        var weekString = String()
        if let data = userInfo{
            switch data.count{
            case 7:
                weekString = "Everyday"
            case 6:
                weekString = "\(data[0]), \(data[1]), \(data[2]), \(data[3]), \(data[4]), \(data[5])"
            case 5:
                weekString = "\(data[0]), \(data[1]), \(data[2]), \(data[3]), \(data[4])"
            case 4:
                weekString = "\(data[0]), \(data[1]), \(data[2]), \(data[3])"
            case 3:
                weekString = "\(data[0]), \(data[1]), \(data[2])"
            case 2:
                weekString = "\(data[0]), \(data[1])"
            case 1:
                weekString = "\(data[0])"
            default:
                weekString = "Everyday"
            }
        
        }
        repeatTime = weekString
        repeattxtLabel.text = weekString
    }
    
    func notifySwiftNotification(Title : String, Body : String, DateTime: Date, id : String){
        let sampleNot = SwiftLocalNotificationModel(title: Title, body: Body, date: DateTime, repeating: .daily, identifier: id)
        
          let snoozeAction = UNNotificationAction(identifier: id, title: "Snooze in 2 minutes", options: [.authenticationRequired, .foreground])
        let category = SwiftLocalNotificationCategory(categoryIdentifier: id, actions: [snoozeAction])
        category.set(forNotifications: sampleNot)

        // if result is not nil then notification is scheduled correctly
        //_ = localNotificationScheduler.schedule(notification: sampleNot)
        _ = localNotificationScheduler.schedule(notification: sampleNot)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      if response.actionIdentifier == "snoozeAction" {
        print("snooze action clicked for notification \(response.notification.asSwiftLocalNotification().identifier)")
      }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      print("did recieve notification in the app ")
      
    }
}



extension Date {
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

}
