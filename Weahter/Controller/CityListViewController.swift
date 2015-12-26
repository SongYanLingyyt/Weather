//
//  CityListViewController.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/21.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit
import CoreData

typealias ChangeCity = (weaid: String) -> Void
protocol CityListViewDelegate {
    
}

class CityListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableV: UITableView!
    var settingBtn: UIButton!
    var dataSource: [Citys]!
    var seletedCell: CityListCell!
    
    var changeCity = ChangeCity?()
    var delegate: CityListViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.25, green: 0.58, blue: 0.92, alpha: 1.00)
        self.tableV = UITableView(frame: CGRectMake(0, 64, 250, self.view.frame.height - 64), style: .Plain)
        self.tableV.tableFooterView = UIView(frame: CGRectZero)
        self.tableV.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableV.delegate = self
        self.tableV.dataSource = self
//        self.tableV.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.tableV.registerNib(UINib(nibName: "CityListCell", bundle: nil), forCellReuseIdentifier: "CityListCellID")
        
        self.dataSource = []
        fetchCity(false)
        self.view.addSubview(self.tableV)
        
        self.settingBtn = UIButton(type: .Custom)
        self.settingBtn.frame = CGRectMake(10, 20, 40, 40)
        self.settingBtn.setImage(UIImage(named: "profile_settings_icon@2x.png"), forState: .Normal)
        self.settingBtn.addTarget(self, action: "settingAction:", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.settingBtn)

    }
    
    func settingAction(btn: UIButton) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.frame = CGRectMake(-250, 0, 250, self.view.frame.height)
            }, completion: nil)
        
        let settingVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        
        //需要从跟视图present
        self.view.window?.rootViewController?.presentViewController(settingVC, animated: true, completion: nil)
    }
 
    //查询entity数据
    func fetchCity(delete: Bool) {
        //获取管理的数据上下文 对象
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
//        var error:NSError?
        
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("Citys",
            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //查询操作
        let fetchedObjects:[AnyObject]? = try! context.executeFetchRequest(fetchRequest)
        if delete == true {
            //删除全部
            for info:Citys in fetchedObjects as! [Citys]{
                context.deleteObject(info)
            }

        } else {
            //遍历查询的结果
            if self.dataSource.count != 0 {
                self.dataSource.removeAll()
            }
            for info:Citys in fetchedObjects as! [Citys]{
                self.dataSource.append(info)
            }
            self.tableV.reloadData()
        }
        
    }
    
    //按条件查找
    func fetchCityId(cityid: String, delete: Bool) -> Bool {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext

        let fetchRequest:NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("Citys",
            inManagedObjectContext: context)
        fetchRequest.entity = entity
        
        let predicate = NSPredicate(format: "cityid=\(cityid)")
        fetchRequest.predicate = predicate
        
        let fetchedObjects:[AnyObject]? = try! context.executeFetchRequest(fetchRequest)
        if delete == true {
            //删除数据
            for info:Citys in fetchedObjects as! [Citys]{
                context.deleteObject(info)
                //删除后保存数据  ===竟然忘了==
                try! context.save()
            }
        }
        if fetchedObjects?.count == 0 {
            return false
        }
        return true
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let string = "CityListCellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(string) as! CityListCell
        cell = NSBundle.mainBundle().loadNibNamed("CityListCell", owner: self, options: nil)[0] as! CityListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let city = self.dataSource[indexPath.row]
        cell.cityNmLab.text = city.citynm
        cell.temperatureLab.text = city.temperature
        
        let url = NSURL(string: city.weatherIcon!)
        let image = UIImage(data: NSData(contentsOfURL: url!)!)
        cell.iconImageView.image = image
        let def = NSUserDefaults.standardUserDefaults()
        let row = def.objectForKey("selectedRow")
        if row == nil {
            if indexPath.row == self.dataSource.count - 1 {
                cell.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
                self.seletedCell = cell
            }
        } else {
            if row as! Int == indexPath.row {
                cell.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
                self.seletedCell = cell
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CityListCell
        let city = self.dataSource[indexPath.row]
        self.changeCity!(weaid: city.weaid!)
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.frame = CGRectMake(-250, 0, 250, self.view.frame.height)
            }, completion: nil)
        let def = NSUserDefaults.standardUserDefaults()
        def.setObject(indexPath.row, forKey: "selectedRow")
        def.synchronize()
        self.seletedCell.backgroundColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        self.seletedCell = cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //删除数据
        let city = self.dataSource[indexPath.row]
        self.fetchCityId(city.cityid!, delete: true)
        //删除数据源
        self.dataSource.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        
    }
    //把deleted改成中文
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    func initChangeCity(fun: (weaid: String) -> Void) {
        changeCity = fun
    }
    
}
