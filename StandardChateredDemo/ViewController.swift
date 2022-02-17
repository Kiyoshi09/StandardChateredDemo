//
//  ViewController.swift
//  StandardChateredDemo
//
//  Created by Kiyoshi Amano on 2022/02/14.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var traceID: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Tealium : Tracking
        TealiumHelper.trackScreen(self, name: "login")
    }
    
    
    @IBAction func onNextScreen(_ sender: Any) {
        
        // Tealium : start Trace
        let _traceId = traceID.text
        if _traceId != nil {
            TealiumHelper.joinTrace(id: _traceId!)
        }
        
        let _userName = userName.text == nil ? "" : userName.text
        UserDefaults.standard.set(_userName, forKey: "customer_email")
        
        // Tealium : Tracking
        let data: Dictionary<String,String> = ["customer_email": _userName!]
        TealiumHelper.trackEvent(title: "user_login", dataLayer: data)
        
        // Move to next screen
        performSegue(withIdentifier: "home", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if(segue.identifier == "home"){
//
//            let tabVC = segue.destination as! UITabBarController
//            let homeVC = tabVC.viewControllers?[0] as! HomeViewController
//
//            homeVC.emailAddress = userName.text
//        }
//    }
}

