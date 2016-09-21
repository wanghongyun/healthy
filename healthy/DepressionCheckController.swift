//
//  DepressionCheckController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/19.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class DepressionCheckController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultView: UIView!
    
    private let questions = ["我觉得经常做的事情并没有困难",
                             "我对将来抱有希望",
                             "我觉得不安而平静不下来",
                             "我的生活过得很有意思",
                             "我觉得一天之中早晨最好",
                             "我无缘无故感到疲乏",
                             "我吃的和平时一样多",
                             "我觉得做出决定是容易的",
                             "我晚上睡眠不好",
                             "我一阵阵地哭出来或是想哭",
                             "我有便秘的苦恼",
                             "我发觉我的体重在下降",
                             "我觉得闷闷不乐，情绪低沉",
                             "我觉得自己是个有用的人，有人需要我",
                             "我比平常容易激动",
                             "我的头脑和平时一样清楚",
                             "我心跳比平时快",
                             "平常感兴趣的事我仍然照样感兴趣",
                             "我认为如果我死了别人会生活的更好些",
                             "我与异性接触时和以往一样感到愉快"]
    
    private let selections = ["A.很少", "B.较少", "C.较多", "D.经常"]
    
    private var answers: [Int: Int] = [Int: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< self.questions.count {
            self.answers[i] = -1
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
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
            cell.isChecked = self.answers[indexPath.section] == indexPath.row
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as! SelectionFooterCell
            cell.button.addTarget(self, action: #selector(self.submit(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.answers[indexPath.section]! = indexPath.row
        tableView.reloadData()
    }
    
    // MARK: action
    func submit(_ sender: UIButton) {
        self.resultView.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.resultView.alpha = 1.0
            }, completion: nil)
    }
    
    @IBAction func closeResult(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.resultView.alpha = 0.0
        }) { (result) in
            self.resultView.isHidden = true
        }
    }

}
