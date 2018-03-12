//
//  CreateAccountViewController.swift
//  Eciept
//
//  Created by Ari Kanevsky on 3/5/18.
//  Copyright © 2018 Ari Kanevsky. All rights reserved.
//
import Alamofire
import Foundation
import UIKit

class CreateAccount : UIViewController, UITextFieldDelegate {

    @IBOutlet var background: UIImageView!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var username_field: UITextField!
    @IBOutlet var email_field: UITextField!
    @IBOutlet var password_field: UITextField!
    @IBOutlet var confirmpassword_field: UITextField!
    @IBOutlet var createaccount_button: UIButton!
    @IBOutlet var login_button: UIButton!
    
    var database_response: String!
    
    //Const URL to register.php file
    let URL_USER_REGISTER = "http://ec2-18-221-175-169.us-east-2.compute.amazonaws.com/register.php"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set login icon
        icon.image = UIImage(named: "Eceipt_seq9")
        
        // Set text fields
        username_field.background = UIImage(named: "Username_field")
        email_field.background = UIImage(named: "Email_field")
        password_field.background = UIImage(named: "NewPassword_field")
        confirmpassword_field.background = UIImage(named: "Password_field")
        
        // Set buttons
        createaccount_button.setBackgroundImage(UIImage(named: "Login_button"), for: .normal)
        createaccount_button.setTitle("Create Account", for: .normal)
        createaccount_button.setTitleColor(UIColor(red:0.49, green:0.44, blue:0.44, alpha:1.0), for: .normal)
        createaccount_button.setBackgroundImage(UIImage(named: "Login_button_highlighted" ), for: .highlighted)
        
        login_button.setBackgroundImage(UIImage(named: "GoTo_button"), for: .normal)
        login_button.setTitle("Back to Login.", for: .normal)
        login_button.setTitleColor(.white, for: .normal)
        login_button.setBackgroundImage(UIImage(named: "GoTo_button_highlighted"), for: .highlighted)
        
        createaccount_button.addTarget(self, action: #selector(createAccount(_:)), for: .touchUpInside)
        login_button.addTarget(self, action: #selector(toLogInView(_:)), for: .touchUpInside)
    }
    
    @objc private func toCreateAccountView(_ : UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createaccount_viewcontroller = storyboard.instantiateViewController(withIdentifier: "CreateAccount") as! CreateAccount
        present(createaccount_viewcontroller, animated: false, completion: nil)
    }
    
    @objc private func createAccount(_ : UIButton) {
        if confirmpassword_field.text == password_field.text {
            let parameters: [String:String] = [
                "username":username_field.text!,
                "password":password_field.text!,
                "email":email_field.text!
            ]
            
            //Send http post request
            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters, encoding:URLEncoding.httpBody).responseJSON {
                
                response in
                
                if let result = response.result.value {
                    
                    print(result)
                    
                    let jsonData = result as! NSDictionary
                    
                    self.database_response = jsonData.value(forKey: "message") as! String?
                }
                
            }
            
        }
        
    }
    
    @objc private func toLogInView(_ : UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let login_viewcontroller = storyboard.instantiateViewController(withIdentifier: "LogIn") as! LogIn
        present(login_viewcontroller, animated: false, completion: nil)
    }
    
    @objc private func userInDatabase() -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.returnKeyType = UIReturnKeyType.next
        if textField == username_field {
            email_field.becomeFirstResponder()
        }else if textField == email_field {
            password_field.becomeFirstResponder()
        }else if textField == password_field {
            confirmpassword_field.becomeFirstResponder()
        }else {
            confirmpassword_field.resignFirstResponder()
            createaccount_button.sendActions(for: .touchUpInside)
        }
        return true
    }
    
}
    

