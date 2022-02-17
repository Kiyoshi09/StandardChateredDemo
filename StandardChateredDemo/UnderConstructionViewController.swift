//
//  UnderConstructionViewController.swift
//  StandardChateredDemo
//
//  Created by Kiyoshi Amano on 2022/02/17.
//

import UIKit

class UnderConstructionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(backToHome),
            userInfo: nil,
            repeats: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc
    func backToHome() {
        dismiss(animated: true, completion: nil)
    }

}
