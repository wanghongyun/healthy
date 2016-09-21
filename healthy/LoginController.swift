//
//  LoginController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/19.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class LoginController: BaseController {
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func login(_ sender: UIButton) {
        if self.userInput.text == "wg" && self.passInput.text == "wg" {
            self.performSegue(withIdentifier: "LoginToTab", sender: nil)
        } else {
            self.showToast("用户名或密码错误")
        }
    }
    
    @IBAction func backgroundTouch(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func eidtDidEnd(_ sender: UITextField) {
        self.view.endEditing(true)
    }
}
