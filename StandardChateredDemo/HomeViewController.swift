//
//  HomeViewController.swift
//  StandardChateredDemo
//
//  Created by Kiyoshi Amano on 2022/02/14.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lblBalance: UILabel!
    
    var emailAddress: String? = ""
    var balance: Double = 11701.39
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        lblBalance.text = formatter.string(from: NSNumber(value: balance))
        
        // Tealium : Tracking
        TealiumHelper.trackScreen(self, name: "home")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func onLogout(_ sender: Any) {
        
        // Tealium : Tracking
        TealiumHelper.trackEvent(title: "user_logout", dataLayer: nil)
        // Tealium : leave Trace
        TealiumHelper.leaveTrace()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBalanceDetails(_ sender: Any) {
        let dest = self.tabBarController?.viewControllers?[1]
        self.tabBarController?.selectedViewController = dest
    }
    
    
    @IBAction func onCreditCard(_ sender: Any) {
    }
    
    @IBAction func onLoan(_ sender: Any) {
    }
    
}
