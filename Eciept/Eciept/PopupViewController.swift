//
//  ViewController.swift
//  Eciept
//
//  Created by Ari Kanevsky on 3/4/18.
//  Copyright © 2018 Ari Kanevsky. All rights reserved.
//

import UIKit

class PopupView: UIView! {

    override func viewDidLoad() {
        super.viewDidLoad()
        PopupView.hidden = true
        // Do any additional setup after loading the view typically from a nib.
    }
    
    private func displayPopup(){
        let popupFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height -200)
        PopupView = UIView(frame: popupFrame)
        
        view.addSubview(<#T##view: UIView##UIView#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didTapButton(_ tap: UITapGestureRecognizer) {
        
    }
}


