//
//  LaunchViewController.swift
//  FamTracker
//
//  Created by Riyasat  on 01/06/22.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        if isLogin == true{
            ScreensManager.shared.dashboard(on: self, modal: true, animated: false)
        }else{
            ScreensManager.shared.loginScren(on: self, modal: true, animated: false)
        }
    }

}
