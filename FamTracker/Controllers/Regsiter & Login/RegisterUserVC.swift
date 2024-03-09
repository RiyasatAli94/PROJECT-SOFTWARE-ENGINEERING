//
//  RegisterUserVC.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit

class RegisterUserVC: UIViewController {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordtxt: UITextField!
    
    
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var mobiletxt: UITextField!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nametxt: UITextField!
    
    @IBOutlet weak var regiterBtnO: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        emailView.layer.cornerRadius = 10
        passwordView.layer.cornerRadius = 10
        mobileView.layer.cornerRadius = 10
        nameView.layer.cornerRadius = 10
        regiterBtnO.layer.cornerRadius = 10
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func keyboardWillShow(notification:NSNotification) {
        self.view.frame.origin.y = 0
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= keyboardSize.height - 70
            }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        if emailTxt.text!.isEmpty || passwordtxt.text!.isEmpty || mobiletxt.text!.isEmpty || nametxt.text!.isEmpty{
            showToast(message: "Please Enter Details", font: .systemFont(ofSize: 14))
        }else if isValidEmail(Utils.unwarpString(string: emailTxt.text)) == false{
            showToast(message: "Enter Valid Email", font: .systemFont(ofSize: 14))
        }else if Utils.unwarpString(string: passwordtxt.text).count < 5{
            showToast(message: "Password should be more then 5 words", font: .systemFont(ofSize: 10))
        }else if Utils.unwarpString(string: mobiletxt.text).count != 10{
            showToast(message: "Enter 10 digit number", font: .systemFont(ofSize: 10))
        }else{
            do{
                try Registration.sharedInstance.SaveUser(email: Utils.unwarpString(string: emailTxt.text), password: Utils.unwarpString(string: passwordtxt.text), mobile: Utils.unwarpString(string: mobiletxt.text), name: Utils.unwarpString(string: nametxt.text))
                dismiss(animated: true)
            }catch{
                print(error)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @IBAction func loginbtn(_ sender: Any) {
        dismiss(animated: true)
    }
}
