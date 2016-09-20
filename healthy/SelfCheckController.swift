//
//  SelfCheckController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/20.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class SelfCheckController: UIViewController {

    @IBOutlet weak var resultView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    // MARK: action
    
    @IBAction func submit(_ sender: UIButton) {
        self.resultView.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.resultView.alpha = 1.0
            }, completion: nil)
    }
    
    @IBAction func hideResult(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.resultView.alpha = 0.0
        }) { (result) in
            self.resultView.isHidden = true
        }
    }
}
