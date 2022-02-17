//
//  TransferViewController.swift
//  StandardChateredDemo
//
//  Created by Kiyoshi Amano on 2022/02/14.
//

import UIKit

class TransferViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvBank: UIPickerView!
    @IBOutlet weak var pvBranch: UIPickerView!
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtAccountNo: UITextField!
    
    private let banks = [
        "Standard Chartered",
        "National Australia",
        "Citi Bank",
        "Westpac Bank",
        "Commonwealth",
        "ANZ Bank"
    ]
    
    private let branches = [
        "Marine Parade",
        "Woodlands",
        "Sydney",
        "Nathan Road",
        "Central",
        "Admiralty"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pvBank.delegate = self
        pvBank.dataSource = self
        
        pvBranch.delegate = self
        pvBranch.delegate = self
        
        // Tealium : Tracking
        TealiumHelper.trackScreen(self, name: "transfer")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        completeView.isHidden = true
        datePicker.isHidden = false
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var n = 0
        
        if pickerView == pvBank {
            n = banks.count
        }
        else {
            n = branches.count
        }
        
        return n
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var s: String?
        
        if pickerView == pvBank {
           s = banks[row]
        }
        else {
            s = branches[row]
        }
        
        return s
    }
    
    
    @IBAction func onTransfer(_ sender: Any) {
        let nBank = pvBank.selectedRow(inComponent: 0)
        let nBranch = pvBranch.selectedRow(inComponent: 0)
        
        let bank = banks[nBank]
        let branch = branches[nBranch]
        
        let account = txtAccountNo.text == nil ? "" : txtAccountNo.text
        let amount = Double(txtAmount.text!) == nil ? 0.0 : Double(txtAmount.text!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: datePicker.date)
        
        // Tealium : Tracking
        let d: Dictionary<String, Any> = [
            "transfer_bank": bank,
            "transfer_branch": branch,
            "transfer_account_no": account ?? "",
            "transfer_money": amount ?? 0.0,
            "transfer_date": date
        ]
        TealiumHelper.trackEvent(title: "money_transfer", dataLayer: d)
        
        
        completeView.isHidden = false
        datePicker.isHidden = true
    }
    
}
