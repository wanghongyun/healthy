//
//  RemindController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/19.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class RemindController: BaseController {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var emptyView: UIView!
    
    private var components: DateComponents!
    
    private var dateText: String {
        get {
            let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)
            let date = gregorianCalendar?.date(from: self.components)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if date != nil {
                return formatter.string(from: date!)
            }
            return ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 44.0)
        button.setTitle("今天", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(self.today(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        self.setupDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDate() {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)
        self.components = gregorianCalendar?.components([.year, .month, .day], from: Date())
        self.dateLabel.text = self.dateText
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func add(_ sender: UIButton) {
        
    }
    @IBAction func previousDay(_ sender: UIButton) {
        self.components.day = self.components.day! - 1
        self.dateLabel.text = self.dateText
    }
    @IBAction func nextDay(_ sender: UIButton) {
        self.components.day = self.components.day! + 1
        self.dateLabel.text = self.dateText
    }
    func today(_ sender: UIButton) {
        self.setupDate()
    }

}
