//
//  AccountViewController.swift
//  StandardChateredDemo
//
//  Created by Kiyoshi Amano on 2022/02/14.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var lblEmailAddress: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let email = UserDefaults.standard.string(forKey: "customer_email")
        lblEmailAddress.text = email
        
        // Tealium : Tracking
        TealiumHelper.trackScreen(self, name: "account")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}