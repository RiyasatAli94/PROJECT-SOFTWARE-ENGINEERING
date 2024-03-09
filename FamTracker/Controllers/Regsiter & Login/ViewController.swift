//
//  ViewController.swift
//  FamTracker
//
//  Created by Riyasat  on 16/05/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var paswordView: UIView!
    
    @IBOutlet weak var passwordtxt: UITextField!
    
    @IBOutlet weak var loginBtno: UIButton!
    @IBOutlet weak var remembercheck: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        emailView.layer.cornerRadius = 10
        paswordView.layer.cornerRadius = 10
        loginBtno.layer.cornerRadius = 10
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        remembar()
        
    }
    
    func remembar(){
        let isRemembar = UserDefaults.standard.bool(forKey: "isRemembar")
        if isRemembar == true{
            let email = UserDefaults.standard.string(forKey: "email")
            let pass = UserDefaults.standard.string(forKey: "pass")
            remembercheck.image = UIImage(named: "checkbox")
            emailTxt.text = email
            passwordtxt.text = pass
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        if isLogin == true{
            ScreensManager.shared.dashboard(on: self, modal: true, animated: false)
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        self.view.frame.origin.y = 0
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= keyboardSize.height - 140
            }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        self.view.frame.origin.y = 0
    }

    @IBAction func loginBtn(_ sender: Any) {
        let email = Utils.unwarpString(string: emailTxt.text)
        let password = Utils.unwarpString(string: passwordtxt.text)
        let userDetails = Registration.sharedInstance.fetchUser(email: email)
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "pass")
        if userDetails.count != 0{
            let pass = userDetails[0].pasword
            if password == pass{
                ScreensManager.shared.dashboard(on: self, modal: true, animated: false)
                UserDefaults.standard.set(true, forKey: "isLogin")
            }else{
                showToast(message: "Enter Valid Password", font: .systemFont(ofSize: 10))
            }
        }else{
            showToast(message: "Please Enter Valid Email", font: .systemFont(ofSize: 10))
        }
    }
    
    @IBAction func newRegsiterBtn(_ sender: Any) {
        ScreensManager.shared.register(on: self, modal: true, animated: false)
    }
    
    @IBAction func aboutUs(_ sender: Any) {
        ScreensManager.shared.aboutUs(on: self, modal: true, animated: false)
    }
    
    @IBAction func remembarBtn(_ sender: Any) {
        let isRemembar = UserDefaults.standard.bool(forKey: "isRemembar")
        if isRemembar == false{
            UserDefaults.standard.set(true, forKey: "isRemembar")
            remembercheck.image = UIImage(named: "checkbox")
        }else{
            remembercheck.image = UIImage(named: "uncheck")
            UserDefaults.standard.set(false, forKey: "isRemembar")
        }
    }
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


