//
//  DateAndTimePickerVC.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit

class DateAndTimePickerVC: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var mainView: UIView!
    var isDate = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 20
        if isDate == true{
            datePicker.datePickerMode = .date
        }else{
            datePicker.datePickerMode = .time
        }
    }
    
    @IBAction func doenBtn(_ sender: Any) {
        let selectDate = DateConverter.myDate(date: datePicker.date)
        let selectTime = DateConverter.myStartTime(date: datePicker.date)
        if isDate == true{
            let userInfo = ["date":selectDate]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getDate"), object: nil, userInfo: userInfo)
        }else{
            let userInfo = ["time":selectTime]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getTime"), object: nil, userInfo: userInfo)
        }
        dismiss(animated: true)
        
    }
    

}
