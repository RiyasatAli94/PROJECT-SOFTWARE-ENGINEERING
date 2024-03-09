//
//  AlertService.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import Foundation
import UIKit


class mapAlertService{
    static var shared = mapAlertService()
    func alertPresent() -> LocationVC{
        let story = UIStoryboard(name: "Alert", bundle: .main)
        let alert = story.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        return alert
    }
}


class dateTimeService{
    static var shared = dateTimeService()
    func alertPresent(isDate : Bool) -> DateAndTimePickerVC{
        let story = UIStoryboard(name: "Alert", bundle: .main)
        let alert = story.instantiateViewController(withIdentifier: "DateAndTimePickerVC") as! DateAndTimePickerVC
        alert.isDate = isDate
        return alert
    }
}

class dayPickerService{
    static var shared = dayPickerService()
    func alertPresent(isSelected : [Bool] , dataArray : [String]) -> DayPickerViewController{
        let story = UIStoryboard(name: "Alert", bundle: .main)
        let alert = story.instantiateViewController(withIdentifier: "DayPickerViewController") as! DayPickerViewController
        alert.isSelected = isSelected
        alert.dataArray = dataArray
        return alert
    }
}

class goalService{
    static var shared = goalService()
    func alertPresent(unitType : [String]) -> GoalViewController{
        let story = UIStoryboard(name: "Alert", bundle: .main)
        let alert = story.instantiateViewController(withIdentifier: "GoalViewController") as! GoalViewController
        alert.unitType = unitType
        return alert
    }
}
