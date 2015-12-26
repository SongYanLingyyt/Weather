//
//  AddCityViewController.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/11.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

typealias cityData = (city: City1) -> Void

class AddCityViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    var tableV: UITableView!
    var searchResult: [City1]!
    var searchBar: UISearchBar!
    var myCity = cityData?()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         searchBar = UISearchBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 100))
        searchBar.placeholder = "搜索~"
        searchBar.barStyle = UIBarStyle.Default
        searchBar.prompt = ""
        searchBar.searchBarStyle = UISearchBarStyle.Default
        searchBar.barTintColor = UIColor(red: 0.25, green: 0.58, blue: 0.92, alpha: 1.00)
        searchBar.tintColor = UIColor.whiteColor()
        searchBar.translucent = true
        searchBar.showsCancelButton = true
        searchBar.showsSearchResultsButton = false
        searchBar.showsScopeBar = false
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        
        self.searchResult = []
        self.tableV = UITableView(frame: CGRectMake(0, 80, self.view.frame.width, self.view.frame.height - 80), style: .Plain)
        self.tableV.tableFooterView = UIView(frame: CGRectZero)
        self.tableV.delegate = self
        self.tableV.dataSource = self
        self.view.addSubview(self.tableV)
        
        //将cancel变成搜索
        for view in self.searchBar.subviews[0].subviews {
            if view.isKindOfClass(UIButton) {
                let cancelBtn = view as! UIButton
                cancelBtn.setTitle("取消", forState: .Normal)
            }
        }
        
    }
    //设置状态栏字体颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func searchRequst(name: String) {
        
        searchResult = CityData.searchCity(name)
        self.tableV.reloadData()
    }
    //#mark  UISearchBarDelegate
    // 输入框内容改变触发事件
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        print("过滤：\(searchText)")
        searchRequst(searchText)
    }

    // 取消按钮触发事件
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        print("取消搜索")
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // 搜索触发事件    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        print("开始搜索")
        searchRequst(self.searchBar.text!)
    }
    
    //#mark table view delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let str = "cellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(str)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: str)
        }
        //刷新CityList选中的行
        let def = NSUserDefaults.standardUserDefaults()
        def.setObject(nil, forKey: "selectedRow")
        def.synchronize()

        //为cell添加标题
        let city = searchResult[indexPath.row]
        cell?.textLabel?.text = city.citynm
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.searchBar.resignFirstResponder()
        let city = searchResult[indexPath.row]
        self.myCity!(city: city)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    func backCityData(data: (city: City1) -> Void) {
        myCity = data
    }
    
}
