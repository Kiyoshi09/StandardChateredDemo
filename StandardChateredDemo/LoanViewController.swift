//
//  LoanViewController.swift
//  StandardChateredDemo
//
//  Created by Kiyoshi Amano on 2022/02/17.
//

import UIKit

class LoanViewController: UIViewController {
    
    @IBOutlet weak var btnMortgage: UIButton!
    @IBOutlet weak var btnCar: UIButton!
    @IBOutlet weak var btnEducation: UIButton!
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
    
    var selectedLoan = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Tealium : Tracking
        TealiumHelper.trackScreen(self, name: "loan")
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
    
    @IBAction func onMortgage(_ sender: Any) {
        btnMortgage.setImage(imgSelected, for: .normal)
        btnCar.setImage(imgNotSelected, for: .normal)
        btnEducation.setImage(imgNotSelected, for: .normal)
        
        selectedLoan = "Mortgage"
    }
    
    @IBAction func onCar(_ sender: Any) {
        btnMortgage.setImage(imgNotSelected, for: .normal)
        btnCar.setImage(imgSelected, for: .normal)
        btnEducation.setImage(imgNotSelected, for: .normal)
        
        selectedLoan = "Car"
    }
    
    
    @IBAction func onEducation(_ sender: Any) {
        btnMortgage.setImage(imgNotSelected, for: .normal)
        btnCar.setImage(imgNotSelected, for: .normal)
        btnEducation.setImage(imgSelected, for: .normal)
        
        selectedLoan = "Education"
    }
    
    @IBAction func onLoanApply(_ sender: Any) {
        completeView.isHidden = false
        
        let _phone = (phone1.text ?? "") + "-" + (phone2.text ?? "") + "-" + (phone3.text ?? "")
        
        let data: Dictionary<String, String> = [
            "loan": selectedLoan,
            "first_name" : firstName.text ?? "",
            "last_name" : lastName.text ?? "",
            "phone": _phone,
            "address1": address1.text ?? "",
            "address2": address2.text ?? "",
        ]
        
        // Tealium: Tracking
        TealiumHelper.trackEvent(title: "apply_loan", dataLayer: data)
        
        
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
