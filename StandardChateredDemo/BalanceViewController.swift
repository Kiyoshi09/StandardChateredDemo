//
//  BalanceViewController.swift
//  StandardChateredDemo
//
//  Created by Kiyoshi Amano on 2022/02/14.
//

import UIKit

class BalanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let transactionDate: Array<String> = [
        "2022/02/14",
        "2022/02/01",
        "2022/01/25",
        "2022/01/20",
        "2022/01/06",
        "2022/01/03",
        "2021/12/24",
        "2021/12/20",
        "2021/12/14",
        "2021/11/14",
        "2021/10/14"
    ]
    
    let transactionCompany: Array<String> = [
        "Tealium Australia",
        "Wouter Vervaat",
        "Hassan Seoud",
        "Kieran Smith",
        "Nick Dennis",
        "Ross Macrae",
        "Jason Lim",
        "Ruby Cheung",
        "Richard Coghlan",
        "Tealium Australia",
        "Tealium Australia",
        "Tealium Australia"
    ]
    
    let transactionBalance: Array<String> = [
        "11,701.39",
        "11,000.00",
        "10,033.00",
        "10,988.21",
        "11,511.09",
        "12,000.00",
        "13,443.79",
        "12,888.88",
        "11,911.00",
        "11,000.00",
        "10,000.00",
         "9,000.00"
    ]
    
    let transactionAmount: Array<String> = [
        "701.39",
        "967.00",
        "-955.21",
        "-522.88",
        "-488.91",
        "-1443.79",
        "554.91",
        "977.88",
        "911.00",
        "1,000.00",
        "1,000.00",
        "3,000.00"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Tealium : Tracking
        TealiumHelper.trackScreen(self, name: "balance_detail")
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let lblDate = cell.contentView.viewWithTag(1) as! UILabel
        let lblBalance = cell.contentView.viewWithTag(2) as! UILabel
        let lblCompany = cell.contentView.viewWithTag(3) as! UILabel
        let lblAmount = cell.contentView.viewWithTag(4) as! UILabel
        
        lblDate.text = transactionDate[indexPath.row]
        lblBalance.text = "Balance " + transactionBalance[indexPath.row]
        lblCompany.text = transactionCompany[indexPath.row]
        lblAmount.text = transactionAmount[indexPath.row]
        if transactionAmount[indexPath.row].starts(with: "-") {
            lblAmount.textColor = .red
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 12
    }
    
    
    
    
}
