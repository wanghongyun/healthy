//
//  RemindController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/19.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class RemindController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var components: DateComponents!
    private var data = [[String: String]]()
    
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
        
        let today = UIButton(type: .custom)
        today.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 44.0)
        today.setTitle("今天", for: .normal)
        today.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        today.setTitleColor(UIColor.white, for: .normal)
        today.addTarget(self, action: #selector(self.today(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: today)
        
        let add = UIButton(type: .custom)
        add.frame = CGRect(x: 0.0, y: 0.0, width: 36.0, height: 44.0)
        add.setImage(UIImage(named: "nav_add"), for: .normal)
        add.addTarget(self, action: #selector(self.add(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: add)
        
        self.tableView.register(UINib(nibName: "ReferralCell", bundle: nil), forCellReuseIdentifier: "ReferralCell")
        
        self.setupDate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getStoredData(key: self.dateText)
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

    func getStoredData(key: String) {
        let save = UserDefaults.standard
        if let values = save.value(forKey: key) as? [[String: String]] {
            self.data = values
        } else {
            self.data.removeAll()
        }
        self.emptyView.isHidden = self.data.count > 0
        self.tableView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let referral = segue.destination as? ReferralController,  identifier == "Referral", sender is [String: String] {
                referral.referral = sender as! [String: String]
            }
        }
    }
 
    
    // MARK: table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReferralCell") as! ReferralCell
        let referral = self.data[indexPath.row]
        cell.nameLabel.text = referral["name"]
        cell.addressLabel.text = referral["address"]
        cell.timeLabel.text = referral["time"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "Referral", sender: self.data[indexPath.row])
    }
    
    @IBAction func add(_ sender: UIButton) {
        let alertController = UIAlertController(title: "请选择您需要添加的内容", message: nil, preferredStyle: .actionSheet)
        let medicalAction = UIAlertAction(title: "用药提醒", style: .default) { (action) in
            // TODO: to medcial
            
        }
        
        let referralAction = UIAlertAction(title: "复诊提醒", style: .default) { (action) in
            self.performSegue(withIdentifier: "Referral", sender: nil)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        alertController.addAction(medicalAction)
        alertController.addAction(referralAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func previousDay(_ sender: UIButton) {
        self.components.day = self.components.day! - 1
        let text = self.dateText
        self.dateLabel.text = text
        self.getStoredData(key: text)
    }
    @IBAction func nextDay(_ sender: UIButton) {
        self.components.day = self.components.day! + 1
        let text = self.dateText
        self.dateLabel.text = text
        self.getStoredData(key: text)
    }
    func today(_ sender: UIButton) {
        self.setupDate()
        self.getStoredData(key: self.dateText)
    }

}
