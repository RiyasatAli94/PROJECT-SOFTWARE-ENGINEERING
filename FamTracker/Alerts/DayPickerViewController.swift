//
//  DayPickerViewController.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit

class DayPickerViewController: UIViewController {
    @IBOutlet weak var dayPicker: UITableView!
    @IBOutlet weak var mainView: UIView!
    var dataArray = [String]()
    var selectedData = [String]()
    var isSelected = [Bool]()
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPicker.delegate = self
        dayPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doenBtn(_ sender: Any) {
        for index in 0...dataArray.count - 1{
            if isSelected[index] == true{
                selectedData.append(dataArray[index])
            }
        }
        
        if dataArray.count == 3{
            let userInfo = ["data":selectedData]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noonList"), object: nil, userInfo: userInfo)
        }else{
            let userInfo = ["data":selectedData]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "weekList"), object: nil, userInfo: userInfo)
        }
        
        
       
        dismiss(animated: true)
    }
}

extension DayPickerViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayPickerTableViewCell", for: indexPath) as! DayPickerTableViewCell
        cell.txt.text = dataArray[indexPath.row]
        if isSelected[indexPath.row] == true{
            cell.img.image = UIImage(named: "checkbox")
        }else{
            cell.img.image = UIImage(named: "uncheck")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelected[indexPath.row] == true{
            isSelected[indexPath.row] = false
        }else{
            isSelected[indexPath.row] = true
        }
        dayPicker.reloadData()
    }
    
    
}
