//
//  MainViewController.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/11.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, RequestDelegate, WeatherViewDelegate, ForecastViewDelegate, UIScrollViewDelegate {

    //常量
    let kWidth = UIScreen.mainScreen().bounds.width
    let kHeight = UIScreen.mainScreen().bounds.height
    
    var topNaView: UIView!
    var moreBtn: UIButton!
    var addBtn: UIButton!
    var contentScrollView: UIScrollView!
    var topLocationLabel: UILabel!
    var backgroungImageView: UIImageView!
    var weatherView: WeatherView!
    var forecastView: ForecastView!
    var aqiView: AQIView!
    
    var todyWeather: WeatherResult!
    var futureWeather: [WeatherResult]!
    var aqiData: APIData!
    
    var listVC: CityListViewController!
    
    var refreshLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initailView()
        self.futureWeather = []
        
        self.listVC = CityListViewController()
        self.listVC.view.frame = CGRectMake(-250, 0, 250, kHeight)
        self.backgroungImageView.addSubview(self.listVC.view)
        
        self.refreshLab = UILabel(frame: CGRectMake(0, 0, kWidth, 30))
        self.refreshLab.textColor = UIColor.whiteColor()
        self.refreshLab.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.refreshLab)
        
        let local = loadLocalData()
        if local == false {
            requstAllData("1")
        }
        
        
    }
    
    func requstAllData(cityCode: String) {
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.contentScrollView.frame = CGRectMake(0, 64 + 30, self.kWidth, self.kHeight)
            self.refreshLab.frame = CGRectMake(0, 64, self.kWidth, 30)
            self.refreshLab.text = "数据刷新中..."
        }
        
        let requst = RequstModel()
        requst.delegate = self
        requst.startRequstWeatherData(cityCode)
        requst.startRequstFutureWeatherData(cityCode)
        requst.startRequstAQIData(cityCode)
    }
    
    func loadLocalData() -> Bool {
        
        let def = NSUserDefaults.standardUserDefaults()
        let dict = def.objectForKey("todayData") as? NSDictionary
        let array = def.objectForKey("futureData") as? NSArray
        let aqiDict = def.objectForKey("aqiData") as? NSDictionary
        
        if array == nil || dict == nil || aqiDict == nil {
           return false
        }
        //今天天气
        let weather = WeatherResult(fromDictionary: dict!)
        self.todyWeather = weather
        
        
        //把之前的数据删除 ====找了好久啊啊啊西八，我说怎么每次都不刷新====
        if self.futureWeather.count != 0 {
            self.futureWeather.removeAll()
        }
        //未来天气
        for weather in array! {
            let data = WeatherResult(fromDictionary: weather as! NSDictionary)
            self.futureWeather.append(data)
        }
        
        if self.listVC != nil {
            let exsit = self.listVC.fetchCityId(self.todyWeather.cityid, delete: false)
            if exsit == false {
                //添加数据到entity
                self.insertData(self.todyWeather)
            }
        }
        //aqi指数
        self.aqiData = APIData(fromDictionary: aqiDict!)
        
        self.loadWeatherData()
        
        return true
    }
    
    //设置状态栏字体颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //初始化
    func initailView() {
        
        self.backgroungImageView = UIImageView(frame: self.view.bounds)
        self.backgroungImageView.userInteractionEnabled = true
        self.view.addSubview(self.backgroungImageView)
        
        self.topNaView = UIView(frame: CGRectMake(0, 0, kWidth, 64))
        self.backgroungImageView.addSubview(self.topNaView)
        
        self.moreBtn = UIButton(type: .Custom)
        self.moreBtn.frame = CGRectMake(10, 20, 40, 40)
        self.moreBtn.setImage(UIImage(named: "moreBtn.png"), forState: .Normal)
        self.moreBtn.addTarget(self, action: "moreBtnAction:", forControlEvents: .TouchUpInside)
        self.topNaView.addSubview(self.moreBtn)
        
        self.addBtn = UIButton(type: .Custom)
        self.addBtn.frame = CGRectMake(kWidth - 50, 20, 40, 40)
        self.addBtn.setImage(UIImage(named: "addBtn.png"), forState: .Normal)
        self.addBtn.addTarget(self, action: "addBtnAction:", forControlEvents: .TouchUpInside)
        self.topNaView.addSubview(self.addBtn)
        
        self.topLocationLabel = UILabel(frame: CGRectMake((kWidth - 200) / 2, 20, 200, 54))
        self.topLocationLabel.textColor = UIColor.whiteColor()
        self.topLocationLabel.textAlignment = NSTextAlignment.Center
        self.topLocationLabel.font = UIFont.systemFontOfSize(20)
        self.topNaView.addSubview(self.topLocationLabel)
        
        self.weatherView = WeatherView(frame: CGRectMake(10, 64, kWidth - 20, kHeight - (kWidth - 20) / 2 - 64))
        self.weatherView.delegate = self
        
        self.contentScrollView = UIScrollView(frame: CGRectMake(0, 64, kWidth, kHeight))
        self.contentScrollView.showsVerticalScrollIndicator = false
        self.contentScrollView.bounces = true
        self.contentScrollView.delegate = self
        self.contentScrollView.contentSize = CGSizeMake(kWidth, kHeight * 2)
        self.backgroungImageView.addSubview(self.contentScrollView)
        
        self.contentScrollView.addSubview(self.weatherView)
        
        self.forecastView = ForecastView(frame: CGRectMake(10, self.weatherView.frame.height + self.weatherView.frame.origin.y + 20, kWidth - 20, kHeight - kWidth / 2))
        self.forecastView.delegate = self
        self.contentScrollView.addSubview(self.forecastView)
        
        self.aqiView = AQIView(frame: CGRectMake(10, self.forecastView.frame.height + self.forecastView.frame.origin.y + 20 ,kWidth - 20,  200))
        self.contentScrollView.addSubview(self.aqiView)
    }

    //更新天气数据
    func loadWeatherData() {
        
        self.topLocationLabel.text = self.todyWeather.citynm
        let weaid = Int(self.todyWeather.weatid)
        let imageName = "w\(weaid! - 1).jpg"
        self.backgroungImageView.image = UIImage(named: imageName)
        self.weatherView.upDateWeatherViewDate(self.todyWeather)
        
        self.forecastView.upDateFutureWeather(self.futureWeather)
        
        self.aqiView.updateAPIData(self.aqiData)
    }
    

    func addBtnAction(btn: UIButton) {
        
        let addVC = AddCityViewController()
        //回调搜索的选择结果
        addVC.backCityData { (city) -> Void in
            self.requstAllData(city.weaid)
        }
        
        self.presentViewController(addVC, animated: true, completion: nil)
        
    }
    
    //插入数据
    func insertData(data: WeatherResult) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
        //创建User对象
        let city = NSEntityDescription.insertNewObjectForEntityForName("Citys",
            inManagedObjectContext: context) as! Citys
        
        //对象赋值
        city.citynm = data.citynm
        city.cityid = data.cityid
        city.cityno = data.cityno
        city.weaid  = data.weaid
        city.temperature = data.temperature
        city.weatherIcon = data.weatherIcon
        //保存
        try! context.save()
        self.listVC.fetchCity(false)
    }
    
    func moreBtnAction(btn: UIButton) {
        
        self.showListView()
        
        }
    
    func showListView() {
        
        self.listVC.view.hidden = false
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.listVC.view.frame = CGRectMake(0, 0, 250, self.kHeight)
            }, completion: nil)
        
        self.listVC.initChangeCity { (weaid) -> Void in
            self.requstAllData(weaid)
        }

    }
    func hiddenListView() {
        
         UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.listVC.view.frame = CGRectMake(-250, 0, 250, self.kHeight)
        }, completion: nil)

    }
    
   //ReqestDelegate 需要在请求数据结束后刷新才可以，用代理实现
    func reloadWeatherData() {
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.contentScrollView.frame = CGRectMake(0, 64, self.kWidth, self.kHeight)
            self.refreshLab.frame = CGRectMake(0, 0, self.kWidth, 30)
            self.refreshLab.text = ""
        }
        
        self.loadLocalData()
        
    }
    
    //WeatherViewDelegate   手势处理
    func swipeWeatherView(direction isRight: Bool) {
        //右滑
        if isRight == true {
            self.showListView()
        }
        //左滑
        else {
            self.hiddenListView()
        }
    }
    //ForecastViewDelegate  
    func swipeForecastView(direction isRight: Bool) {
        //右滑
        if isRight == true {
            self.showListView()
        }
            //左滑
        else {
            self.hiddenListView()
        }
    }
    //获取偏移量 下拉刷新
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        if y < -100 {
            self.requstAllData(self.todyWeather.weaid)
            self.loadLocalData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.listVC.tableV.reloadData()
    }
}
