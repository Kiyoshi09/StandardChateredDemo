//
//  CreditCardViewController.swift
//  StandardChateredDemo
//
//  Created by Kiyoshi Amano on 2022/02/16.
//

import UIKit

class CreditCardViewController: UIViewController {
    
    
    @IBOutlet weak var btnMaster: UIButton!
    @IBOutlet weak var btnVisa: UIButton!
    @IBOutlet weak var btnAmex: UIButton!
    @IBOutlet weak var completeView: UIView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone1: UITextField!
    @IBOutlet weak var phone2: UITextField!
    @IBOutlet weak var phone3: UITextField!
    @IBOutlet weak var address1: UITextField!
    @IBOutlet weak var address2: UITextField!
    
    
    let imgSelected = UIImage(systemName: "circle.inset.filled")
    let imgNotSelected = UIImage(systemName: "circlebadge")
    
    var selectedCreditCard = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Tealium : Tracking
        TealiumHelper.trackScreen(self, name: "credit_card")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        completeView.isHidden = true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onSelectMasterCard(_ sender: Any) {
        btnMaster.setImage(imgSelected, for: .normal)
        btnVisa.setImage(imgNotSelected, for: .normal)
        btnAmex.setImage(imgNotSelected, for: .normal)
        
        selectedCreditCard = "Master Card"
    }
    
    
    @IBAction func onSelectVisaCard(_ sender: Any) {
        btnMaster.setImage(imgNotSelected, for: .normal)
        btnVisa.setImage(imgSelected, for: .normal)
        btnAmex.setImage(imgNotSelected, for: .normal)
        
        selectedCreditCard = "Visa"
    }
    
    
    @IBAction func onSelectAmexCard(_ sender: Any) {
        btnMaster.setImage(imgNotSelected, for: .normal)
        btnVisa.setImage(imgNotSelected, for: .normal)
        btnAmex.setImage(imgSelected, for: .normal)
        
        selectedCreditCard = "Amex"
    }
    
    @IBAction func onApply(_ sender: Any) {
        completeView.isHidden = false
        
        let _phone = (phone1.text ?? "") + "-" + (phone2.text ?? "") + "-" + (phone3.text ?? "")
        
        let data: Dictionary<String, String> = [
            "credit_card": selectedCreditCard,
            "first_name" : firstName.text ?? "",
            "last_name" : lastName.text ?? "",
            "phone": _phone,
            "address1": address1.text ?? "",
            "address2": address2.text ?? "",
        ]
        
        // Tealium: Tracking
        TealiumHelper.trackEvent(title: "apply_credit_card", dataLayer: data)
        
        Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(backToHome),
            userInfo: nil,
            repeats: false)
    }
    
    @objc
    func backToHome() {
        dismiss(animated: true, completion: nil)
    }
    
}
