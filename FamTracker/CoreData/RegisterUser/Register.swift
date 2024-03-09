//
//  Register.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import Foundation
import CoreData
import SystemConfiguration
import UIKit

class Registration{
    let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let sharedInstance = Registration()
    // @see IUserDataAccess.create
    func create() throws{
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        // Create Entity Description
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Register", into: context) as! Register
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
    
    func SaveUser(email : String, password : String, mobile : String, name : String) throws{
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        // Create Entity Description
        let newSignal = NSEntityDescription.insertNewObject(forEntityName: "Register", into: context) as! Register
        newSignal.email = email
        newSignal.pasword = password
        newSignal.mobile = mobile
        newSignal.name = name
        do {
            try context.save()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Classes"), object: nil, userInfo: nil)
        } catch  {
            print("Something went wrong.")
            
        }
    }
    
    
    
    // MARK: -  Updating Configuration
    /// updating configuration when getting from OTA push Notification
    ///   updateConfiguration calling in Appdelegete didReceiveNotification and willReceiveNotification
    /// context is create connection between databse and app
    /// fetchRequest is fetching table from database.(Signal is table name)
    func updateConfiguration(id : String , isReminder : Bool){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managecotxt = appdelegate.persistentContainer.viewContext
        let fetchcontxt : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Register")
        fetchcontxt.predicate = NSPredicate(format: "id = %@", id)
        
        do{
            let enity = try managecotxt.fetch(fetchcontxt)
            let objectlist = enity[0] as! NSManagedObject
            objectlist.setValue(isReminder, forKey: "isReminder")
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
    
    func fetchUser(email : String) -> [Register]{
        var SignalArray = [Register]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        do {
            let results = try context.fetch(fetchRequest)
            let sign = results as! [Register]
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
    
    func fetchObservation() -> [Register]{
        var SignalArray = [Register]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        do {
            let results = try context.fetch(fetchRequest)
            let sign = results as! [Register]
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
    func deleteObservation(title : String){
        // Initialize Fetch Request
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
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
    func deleteObservation(){
        // Initialize Fetch Request
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Register"), object: nil, userInfo: nil)
            
        } catch {
            // Error Handling
            // ...
        }
    }
    
}




