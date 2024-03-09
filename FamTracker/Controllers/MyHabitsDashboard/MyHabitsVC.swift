//
//  MyHabitsVC.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit
import SwiftLocalNotification

var localNotificationScheduler: SwiftLocalNotification!
class MyHabitsVC: UIViewController {
    @IBOutlet weak var myHabitTV: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    var habitData = [Habits]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myHabitTV.delegate = self
        myHabitTV.dataSource = self
        addBtn.layer.cornerRadius = addBtn.frame.height / 2
        habitData = habits.sharedInstance.fetchHabit()
    }
    @IBAction func addNewHabits(_ sender: Any) {
        ScreensManager.shared.listhabit(on: self, modal: true, animated: false)
    }
    
    @IBAction func aboutUs(_ sender: Any) {
        ScreensManager.shared.aboutUs(on: self, modal: true, animated: false)
    }
    
    
    
}

extension MyHabitsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyHabitsTableViewCell", for: indexPath) as! MyHabitsTableViewCell
        cell.habitName.text = habitData[indexPath.row].habitName
        cell.habitImg.image = UIImage(data: habitData[indexPath.row].icon!)
        cell.habitTie.text = habitData[indexPath.row].reminderTime
        cell.TimeOfDay.text = habitData[indexPath.row].reapetTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = habitData[indexPath.row]
        ScreensManager.shared.showHabits(data: data, on: self, modal: true, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // Write action code for the trash
        let TrashAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Delete action ...")
            habits.sharedInstance.deleteHabit(id: Utils.unwarpString(string:  self.habitData[indexPath.row].id))
            localNotificationScheduler.cancel(notificationIds: Utils.unwarpString(string: self.habitData[indexPath.row].id))
            self.habitData.removeAll()
            self.habitData = habits.sharedInstance.fetchHabit()
            self.myHabitTV.reloadData()
            success(true)
        })
        TrashAction.backgroundColor = .red
        
        // Write action code for the Flag
        let FlagAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Edit action ...")
            ScreensManager.shared.createYourOwnEdit(isEdit: true, data: self.habitData[indexPath.row], on: self, modal: true, animated: false)
            success(true)
        })
        FlagAction.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [TrashAction,FlagAction])
    }
    
}
