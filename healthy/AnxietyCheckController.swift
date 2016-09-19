//
//  AnxietyCheckController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/19.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class AnxietyCheckController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private let questions = ["我感到紧张或痛苦",
                             "我对以往感兴趣的事情还是感兴趣",
                             "我感到有些害怕，好像预感到有什么可怕的事情要发生",
                             "我能够哈哈大笑，并看到事务有趣的一面",
                             "我心中充满烦恼",
                             "我感到愉快",
                             "我能够安闲而轻松地坐着",
                             "我感到人好像变迟钝了",
                             "我感到一种令人发抖的恐惧",
                             "我对自己的外表（打扮自己）失去兴趣",
                             "我有点坐立不安，好像感到非要活动不可",
                             "我怀着愉快的心情憧憬未来",
                             "我突然有恐惧感",
                             "我能欣赏一本好书或一项好的广播或电视节目"]
    
    private let selections = ["A.几乎所有时候", "B.大多时候", "C.有时", "D.根本没有"]
    
    private var answers: [Int: Bool] = [Int: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< self.questions.count {
            self.answers[i] = false
        }
        
        self.tableView.register(UINib(nibName: "SelectionCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.register(UINib(nibName: "SelectionFooterCell", bundle: nil), forCellReuseIdentifier: "FooterCell")
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
    
    // MARK: - Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.questions.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < self.questions.count {
            return self.selections.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < self.questions.count {
            return 85.0
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section < self.questions.count {
            if let header = Bundle.main.loadNibNamed("SelectionHeader", owner: nil, options: nil)?[0] as? SelectionHeader {
                header.markLabel.text = "问题\(section + 1)"
                header.contentLabel.text = self.questions[section]
                return header
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < self.questions.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SelectionCell
            cell.selectionLabel.text = self.selections[indexPath.row]
            cell.isChecked = self.answers[indexPath.section]!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as! SelectionFooterCell
            cell.button.addTarget(self, action: #selector(self.submit(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.answers[indexPath.section]! = !self.answers[indexPath.section]!
        let cell = tableView.cellForRow(at: indexPath) as! SelectionCell
        cell.isChecked = self.answers[indexPath.section]!
    }
    
    func submit(_ sender: UIButton) {
        
    }
}
