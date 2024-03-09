//
//  Habits.swift
//  FamTracker
//
//  Created by Riyasat  on 19/05/22.
//

import Foundation
import CoreData
import SystemConfiguration
import UIKit

class habits{
    let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let sharedInstance = habits()
    // @see IUserDataAccess.create
    func create() throws{
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        // Create Entity Description
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Habits", into: context) as! Register
        newUser.mobile = ""
        
        do {
            try context.save()
        } catch  {
            print("Something went wrong.")
        }
    }
    
    // MARK: -  Saved all signal in local database
    /// if Mobile is offline then we will save into local databae
    /// context is create connection between databse and app
    /// fetchRequest is fetching table from database.(Signal is table name)
    
    func SaveHabit(img : Data, lat : Double, long : Double,id : String, Dict : [String : String]) throws{
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        // Create Entity Description
        let newhabit = NSEntityDescription.insertNewObject(forEntityName: "Habits", into: context) as! Habits
        newhabit.icon = img
        newhabit.lat = lat
        newhabit.long = long
        newhabit.id = NSUUID().uuidString
        newhabit.habitName = Dict["habitName"]
        newhabit.reapetTime = Dict["repeat"]
        newhabit.goal = Dict["goal"]
        newhabit.timeOfDay = Dict["timeofday"]
        newhabit.reminderTime = Dict["rimDay"]
        newhabit.startDate = Dict["startDate"]
        newhabit.location = Dict["location"]
        do {
            try context.save()
            print("Habit save sucessfully")
        } catch  {
            print("Something went wrong.")
            
        }
    }
    
    
    
    // MARK: -  Updating Configuration
    /// updating configuration when getting from OTA push Notification
    ///   updateConfiguration calling in Appdelegete didReceiveNotification and willReceiveNotification
    /// context is create connection between databse and app
    /// fetchRequest is fetching table from database.(Signal is table name)
    func updateHabit(id : String , img : Data, lat : Double, long : Double, Dict : [String : String]){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managecotxt = appdelegate.persistentContainer.viewContext
        let fetchcontxt : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Habits")
        fetchcontxt.predicate = NSPredicate(format: "id = %@", id)
        
        do{
            let enity = try managecotxt.fetch(fetchcontxt)
            let objectlist = enity[0] as! NSManagedObject
            objectlist.setValue(img, forKey: "icon")
            objectlist.setValue(lat, forKey: "lat")
            
            objectlist.setValue(long, forKey: "long")
            objectlist.setValue(Dict["habitName"], forKey: "habitName")
            objectlist.setValue(Dict["repeat"], forKey: "reapetTime")
            objectlist.setValue(Dict["goal"], forKey: "goal")
            objectlist.setValue(Dict["timeofday"], forKey: "timeOfDay")
            objectlist.setValue(Dict["rimDay"], forKey: "reminderTime")
            objectlist.setValue(Dict["startDate"], forKey: "startDate")
            objectlist.setValue(Dict["location"], forKey: "location")
            do{
                
                try managecotxt.save()
            }catch{
            }
        }catch{
            print(error)
        }
        
    }
    
    
    // MARK: -  getting all signal from local database for store
    /// if Mobile is offline then we will save into local databae
    /// context is create connection between databse and app
    /// fetchRequest is fetching table from database.(Signal is table name)
    
    func fetchHabit(id : String) -> [Habits]{
        var SignalArray = [Habits]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        do {
            let results = try context.fetch(fetchRequest)
            let sign = results as! [Habits]
            SignalArray = sign
            for sign1 in sign {
                print(sign1)//
            }
        }catch let err as NSError {
            print(err.debugDescription)
            
        }
        return SignalArray
    }
    
    
    // MARK: -  getting all signal from local database for store
    /// if Mobile is offline then we will save into local databae
    /// context is create connection between databse and app
    /// fetchRequest is fetching table from database.(Signal is table name)
    
    func fetchHabit() -> [Habits]{
        var SignalArray = [Habits]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        do {
            let results = try context.fetch(fetchRequest)
            let sign = results as! [Habits]
            SignalArray = sign
            for sign1 in sign {
                print(sign1)//
            }
        }catch let err as NSError {
            print(err.debugDescription)
            
        }
        return SignalArray
    }
    
    // MARK :-  deleting signals in local database when all signals send one by one
    /// if Mobile is comes online then we will delete all signals into local databae
    /// context is create connection between databse and app
    /// fetchRequest is fetching table from database.(Signal is table name)
    func deleteHabit(id : String){
        // Initialize Fetch Request
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try context.fetch(fetchRequest)
            
            for item in items {
                // Deleting object from database
                context.delete(item as! NSManagedObject)
            }
            
            // Save Changes
            try context.save()
            // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SignalDeleted"), object: nil, userInfo: nil)
            
        } catch {
            // Error Handlingdo{
            // ...
        }
    }
    
    // MARK :-  deleting signals in local database when all signals send one by one
    /// if Mobile is comes online then we will delete all signals into local databae
    /// context is create connection between databse and app
    /// fetchRequest is fetching table from database.(Signal is table name)
    func deletehabit(){
        // Initialize Fetch Request
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try context.fetch(fetchRequest)
            
            for item in items {
                // Deleting object from database
                context.delete(item as! NSManagedObject)
            }
            
            // Save Changes
            try context.save()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Habits"), object: nil, userInfo: nil)
            
        } catch {
            // Error Handling
            // ...
        }
    }
    
}




