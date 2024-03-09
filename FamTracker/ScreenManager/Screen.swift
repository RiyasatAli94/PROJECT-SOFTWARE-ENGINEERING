//
//  Screen.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import Foundation
import UIKit

/// Object of the Screen  Manager Class
let Screens = ScreensManager.shared

// Screen Manager use to manage all view controller push present and navigation
/// shared veriable is a singaltan instance of the screen manager class
class ScreensManager{
    static let shared = ScreensManager()
    var baseViewController:UIViewController?
    /// This mehtod user to present and push navigation controller form one controller to other contrller
    fileprivate func showViewController(_ viewController : UIViewController, on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        if modal {
            if let parentVC = parent {
                parentVC.present(viewController, animated: animated)
            } else {
                baseViewController?.present(viewController, animated: animated)
            }
        } else {
            if let nav = parent as? UINavigationController {
                nav.pushViewController(viewController, animated: animated)
            } else {
                print("Did not pass in a navigation controller to push on")
            }
        }
    }
    
    /// This method to present category view controller
    func createYourOwnShow(img : UIImage, title : String, on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "CreateYourOwnVC") as? CreateYourOwnVC {
            vc.image = img
            vc.titles = title
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
    
    func createYourOwnEdit(isEdit : Bool, data : Habits, on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "CreateYourOwnVC") as? CreateYourOwnVC {
            vc.isEdit = isEdit
            vc.editableHabitData = data
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
    /// This method to present category view controller
    func register( on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterUserVC") as? RegisterUserVC {
            
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
    /// This method to present category view controller
    func login( on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
    func dashboard( on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "MyHabitsVC") as? MyHabitsVC {
            
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
    func loginScren( on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
    func listhabit( on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "ListHabbitsViewController") as? ListHabbitsViewController {
            
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
    func showHabits(data : Habits, on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "showHabitsViewController") as? showHabitsViewController {
            vc.habitsData = data
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
   
    func yogaPase( on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "YogaPoseViewController") as? YogaPoseViewController {
            
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
    func aboutUs( on parent : UIViewController? = nil, modal: Bool = false, animated : Bool = true) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
            
            showViewController(vc, on: parent, modal: modal, animated: animated)
        }
    }
    
}
