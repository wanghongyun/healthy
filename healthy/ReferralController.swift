//
//  ReferralController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/20.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class ReferralController: BaseController, UITextViewDelegate {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var remarkInput: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var textPlaceHolder: UILabel!
    
    var referral: [String: String] = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let save = UIButton(type: .custom)
        save.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 44.0)
        save.setTitle("保存", for: .normal)
        save.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        save.setTitleColor(UIColor.white, for: .normal)
        save.addTarget(self, action: #selector(self.save(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: save)
        
        if self.referral["name"] != nil {
            self.nameInput.text = self.referral["name"]
        }
        if self.referral["address"] != nil {
            self.addressInput.text = self.referral["address"]
        }
        if self.referral["date"] != nil {
            self.dateLabel.text = self.referral["date"]
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.dateLabel.text = formatter.string(from: Date())
        }
        if self.referral["time"] != nil {
            self.timeLabel.text = self.referral["time"]
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            self.timeLabel.text = formatter.string(from: Date())
        }
        if self.referral["remark"] != nil {
            self.remarkInput.text = self.referral["remark"]
            self.textPlaceHolder.isHidden = true
        }
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

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let nsString = textView.text as NSString
        let newString = nsString.replacingCharacters(in: range,
                                                     with: text)
        self.textPlaceHolder.isHidden = newString.lengthOfBytes(using: .utf8) > 0
        return true
    }
    
    func showDatePicker(mode: UIDatePickerMode, targetLabel: UILabel) {
        self.view.endEditing(true)
        
        var message = ""
        if mode == .date {
            message = "请选择日期"
        } else if mode == .time {
            message = "请选择时间"
        }
        let alertController = UIAlertController(title: "", message: "\(message)\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        let datePicker = UIDatePicker(frame: CGRect(x: 15.0, y: 30.0, width: 270.0, height: 200.0))
        datePicker.datePickerMode = mode
        alertController.view.addSubview(datePicker)
        
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
            let selectedDate = datePicker.date
            let formatter = DateFormatter()
            if mode == .date {
                formatter.dateFormat = "yyyy-MM-dd"
                targetLabel.text = formatter.string(from: selectedDate)
            } else if mode == .time {
                formatter.dateFormat = "HH:mm"
                targetLabel.text = formatter.string(from: selectedDate)
            }
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(sureAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: action
    @IBAction func backgroundTouch(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func editDidEnd(_ sender: UITextField) {
        self.view.endEditing(true)
    }
    
    @IBAction func selectDate(_ sender: UIButton) {
        self.showDatePicker(mode: .date, targetLabel: self.dateLabel)
    }
    
    @IBAction func selectTime(_ sender: UIButton) {
        self.showDatePicker(mode: .time, targetLabel: self.timeLabel)
    }
    
    func save(_ sender: UIButton) {
        self.view.endEditing(true)
        
        guard let name = self.nameInput.text, name.lengthOfBytes(using: .utf8) > 0 else {
            self.showToast("请输入复诊项目")
            return
        }
        
        guard let address = self.addressInput.text, address.lengthOfBytes(using: .utf8) > 0 else {
            self.showToast("请输入地址")
            return
        }
        
        var value = [String: String]()
        value["name"] = name
        value["address"] = address
        value["date"] = self.dateLabel.text!
        value["time"] = self.timeLabel.text!
        if let remark = self.remarkInput.text, remark.lengthOfBytes(using: .utf8) > 0 {
            value["remark"] = remark
        }
        
        let save = UserDefaults.standard
        if var values = save.value(forKey: self.dateLabel.text!) as? [[String: String]] {
            if let index = values.index(where: { $0["name"] == self.referral["name"]}) {
                values[index] = value
            } else {
                values.append(value)
            }
            save.set(values, forKey: self.dateLabel.text!)
        } else {
            save.setValue([value], forKey: self.dateLabel.text!)
        }
        
        if save.synchronize() {
            self.showToast("保存成功")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                _ = self.navigationController?.popViewController(animated: true)
            }
        } else {
            self.showToast("保存失败")
        }
    }
    
}
