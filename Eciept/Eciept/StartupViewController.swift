//
//  StartupViewController.swift
//  Eciept
//
//  Created by Ari Kanevsky on 3/5/18.
//  Copyright © 2018 Ari Kanevsky. All rights reserved.
//

import UIKit
import Dispatch

class StartupViewController: UIViewController {
    
    var images: [UIImage]!
    
    var animatedImage: UIImage!

    @IBOutlet var startup_animation: UIImageView!
    @IBOutlet var startup_text: UIImageView!
    

    var seq_1 : UIImage!
    var seq_2 : UIImage!
    var seq_3 : UIImage!
    var seq_4 : UIImage!
    var seq_5 : UIImage!
    var seq_6 : UIImage!
    var seq_7 : UIImage!
    var seq_8 : UIImage!
    var seq_9 : UIImage!
    var seq_10 : UIImage!
    var seq_11 : UIImage!
    var seq_12 : UIImage!
    var seq_13 : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        seq_1 = UIImage(named: "Eceipt_seq1")
        seq_2 = UIImage(named: "Eceipt_seq2")
        seq_3 = UIImage(named: "Eceipt_seq3")
        seq_4 = UIImage(named: "Eceipt_seq4")
        seq_5 = UIImage(named: "Eceipt_seq5")
        seq_6 = UIImage(named: "Eceipt_seq6")
        seq_7 = UIImage(named: "Eceipt_seq7")
        seq_8 = UIImage(named: "Eceipt_seq8")
        seq_9 = UIImage(named: "Eceipt_seq9")
        seq_10 = UIImage(named: "Eceipt_seq10")
        seq_11 = UIImage(named: "Eceipt_seq11")
        seq_12 = UIImage(named: "Eceipt_seq12")
        seq_13 = UIImage(named: "Eceipt_seq13")
        
        images = [seq_1 ,seq_2, seq_3, seq_4, seq_5, seq_6, seq_7, seq_8, seq_9, seq_10, seq_11, seq_12, seq_13]
        
        animatedImage = UIImage.animatedImage(with: images, duration: 1.0)
        
        startup_animation.image = animatedImage
        
        let transition_text = UIImage(named: "Eceipt_logo")
        
        UIView.transition(with: self.startup_text, duration: 2.0, options: .transitionCrossDissolve,
                          animations: {
                            self.startup_text.image = transition_text
        },
                          completion: { (finished: Bool) -> () in
                            self.toStatic()
        })
        
    }
    
    @objc private func toStatic(){
        self.startup_animation.image = self.seq_9
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.toLogInView()
        }
    }
    
    @objc private func toLogInView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let login_viewcontroller = storyboard.instantiateViewController(withIdentifier: "LogIn") as! LogIn
        present(login_viewcontroller, animated: false, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
