//
//  GoalViewController.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit

class GoalViewController: UIViewController {
    
    @IBOutlet var gaolPcikerView : UIPickerView!
    @IBOutlet var goalView : UIView!
    var Numbers = [Int]()
    var unitType = [String]()
    var selectNumber = String()
    var selectUnit = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        values()
        gaolPcikerView.delegate = self
        gaolPcikerView.dataSource = self
        selectNumber = "\(Numbers[0])"
        selectUnit = unitType[0]
    }
    
    @IBAction func doenBtn(_ sender: Any) {
        let selectedData = "\(selectNumber) \(selectUnit)"
        let userInfo = ["data":selectedData]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goal"), object: nil, userInfo: userInfo)
        dismiss(animated: true)
    }
    
    func values()
    {
        for val in 0...100{
            Numbers.append(val)
        }
    }

}

extension GoalViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return Numbers.count
        }
        return unitType.count
    }
    
    //MARK:- UIPickerViewDelegates methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return "\(Numbers[row])"
        }
        return unitType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            selectNumber = "\(Numbers[row])"
        }else{
            selectUnit = unitType[row]
        }
    }
    
}
