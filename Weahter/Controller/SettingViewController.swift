//
//  SettingViewController.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/22.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentBackLight: Float = 0
    
    var tableV: UITableView!
    var dataSource: [String]!
    let ww = UIScreen.mainScreen().bounds.width
    let hh = UIScreen.mainScreen().bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
//        let bl = CFPreferencesCopyAppValue("SBBacklightLevel", "com.apple.springboard")
        
//        self.currentBackLight = bl.floatValue
        
        self.tableV = UITableView(frame: CGRectMake(0, 64, ww, hh - 64), style: .Grouped)
        self.tableV.delegate = self
        self.tableV.dataSource = self
        self.view.addSubview(self.tableV)
        self.dataSource = ["夜间模式", "关于", "反馈"]
    }

    @IBAction func backAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }

    //table view delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cellID")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cellID")
        }
        
        cell?.textLabel?.text = self.dataSource[indexPath.row]
        
        if indexPath.row == 0 {
            let switchs = UISwitch(frame: CGRectMake(self.view.frame.width - 60, 10, 80, 44))
            switchs.on = false
            cell?.contentView.addSubview(switchs)
        } else {
            let arrow = UIImageView(frame: CGRectMake(self.view.frame.width - 60, 0, 44, 44))
            arrow.image = UIImage(named: "arrow_r.png")
            cell?.contentView.addSubview(arrow)
        }
        
        return cell!
    }

}
