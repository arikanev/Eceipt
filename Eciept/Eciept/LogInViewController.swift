//
//  LogInViewController.swift
//  Eciept
//
//  Created by Ari Kanevsky on 3/5/18.
//  Copyright © 2018 Ari Kanevsky. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

class LogIn : UIViewController, UITextFieldDelegate, URLSessionDataDelegate{

    @IBOutlet var background: UIImageView!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var username_field: UITextField!
    @IBOutlet var password_field: UITextField!
    @IBOutlet var createaccount_button: UIButton!
    @IBOutlet var login_button: UIButton!
    @IBOutlet var popup_view: UIView!
    @IBOutlet var createaccount_button_small: UIButton!
    @IBOutlet var ok_button: UIButton!
    
    private var response: String!
    private var error: Bool!

    
    let URL_USER_LOGIN = "http://ec2-18-221-175-169.us-east-2.compute.amazonaws.com/login.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popup_view.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set login icon
        self.icon.image = UIImage(named: "Eceipt_seq9")
        
        // Set text fields
        self.username_field.background = UIImage(named: "Username_field")
        self.password_field.background = UIImage(named: "Password_field")
        
        // Set popupview
        self.popup_view.addBackground(imageName: "popup_view", contentMode: .scaleAspectFit)
        self.popup_view.isHidden = true
        
        self.ok_button.addTarget(self, action: #selector(pressedOk), for: .touchUpInside)
        self.ok_button.setTitle("Ok", for: .normal)
        self.ok_button.titleLabel?.font = .systemFont(ofSize: 14)
        self.ok_button.setTitleColor(UIColor(red:0.65, green:0.91, blue:0.93, alpha:1.0), for: .normal)
        self.ok_button.setBackgroundImage(UIImage(named: "ok_button_highlighted"), for: .highlighted)
        
        self.createaccount_button_small.addTarget(self, action: #selector(toCreateAccountView), for: .touchUpInside)
        self.createaccount_button_small.setTitle("Create Account", for: .normal)
        self.createaccount_button_small.titleLabel?.font = .systemFont(ofSize: 14)
        self.createaccount_button_small.setTitleColor(UIColor(red:0.65, green:0.91, blue:0.93, alpha:1.0), for: .normal)
        self.createaccount_button_small.setBackgroundImage(UIImage(named: "createaccount_button_small_highlighted"), for: .highlighted)
        
        self.popup_view.addSubview(ok_button)
        self.popup_view.addSubview(createaccount_button_small)

        
        // Set buttons
        self.login_button.setBackgroundImage(UIImage(named: "Login_button"), for: .normal)
        self.login_button.setTitle("Log In", for: .normal)
        self.login_button.setTitleColor(UIColor(red:0.49, green:0.44, blue:0.44, alpha:1.0), for: .normal)
        self.login_button.setBackgroundImage(UIImage(named: "Login_button_highlighted" ), for: .highlighted)
        
        self.createaccount_button.setBackgroundImage(UIImage(named: "GoTo_button"), for: .normal)
        self.createaccount_button.setTitle("New to Eceipt?      Create an Account.", for: .normal)
        self.createaccount_button.setTitleColor(.white, for: .normal)
        self.createaccount_button.setBackgroundImage(UIImage(named: "GoTo_button_highlighted"), for: .highlighted)
        
        self.login_button.addTarget(self, action: #selector(logIn(_:)), for: .touchUpInside)
        self.createaccount_button.addTarget(self, action: #selector(toCreateAccountView(_:)), for: .touchUpInside)
    }
    
    @objc private func toCreateAccountView(_ : UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createaccount_viewcontroller = storyboard.instantiateViewController(withIdentifier: "CreateAccount") as! CreateAccount
        present(createaccount_viewcontroller, animated: false, completion: nil)
    }
    
    @objc private func logIn(_ : UIButton) {
        
        if (username_field.text != nil) && (password_field.text != nil) {
            
            let parameters: [String:String] = [
                "username":username_field.text!,
                "password":password_field.text!
            ]
            
            //Send http post request
            Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters, encoding:URLEncoding.httpBody).responseJSON {
                
                response in

                if let result = response.result.value {
                    
                    print(result)
                    let json_data = result as! NSDictionary
                    
                    self.response = json_data.value(forKey: "message") as! String?
                    
                    self.error = json_data.value(forKey: "error") as! Bool
                    
                    if (self.error) {
                        
                        self.loadPopupView(response: self.response)
                        
                    } else {
                        
                    }
                    
                }
                
            }
            
        }

    }
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.returnKeyType = UIReturnKeyType.next
        if textField == username_field{
            password_field.becomeFirstResponder()
        }else{
            password_field.resignFirstResponder()
            login_button.sendActions(for: .touchUpInside)
        }
        return true
    }
    
    private func loadPopupView(response : String) {
        self.popup_view.isHidden = false
        let response = NSAttributedString(string : response)
        let text_frame = CGRect(x: 0, y: 16, width: popup_view.frame.width, height: 50)
        let text = UITextView(frame: text_frame)
        text.attributedText = response
        text.backgroundColor = UIColor.clear
        text.isEditable = false
        text.textAlignment = .center
        text.textColor = UIColor(red:0.49, green:0.44, blue:0.44, alpha:1.0)
        text.font = .systemFont(ofSize: 20)
        self.popup_view.addSubview(text)
    }
    
    @objc private func pressedOk(_ :UIButton) {
        
        popup_view.isHidden = true
        
    }
    
    
    
}
extension UIView {
    func addBackground(imageName: String = "YOUR DEFAULT IMAGE NAME", contentMode: UIViewContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundImageView)
        sendSubview(toBack: backgroundImageView)
        
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
