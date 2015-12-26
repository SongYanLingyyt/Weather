//
//  RequstModel.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/16.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

//typealias responseWeather = (dict: NSDictionary) -> Void  //
//typealias responseFutureWeather = (array: NSArray) -> Void

protocol RequestDelegate {
    func reloadWeatherData()
}

class RequstModel: NSObject {
//
//    var myFun = responseWeather?()
//    var future = responseFutureWeather?()
    
//     http://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json
    
    var delegate: RequestDelegate!
    
    let headUrl = "http://api.k780.com:88/?app=weather.today&weaid="
    let tailUrl = "&&appkey=16869&sign=45ca0f2ab1e5d188c48de9c51f2497e4&format=json"
    
    let headUrlFuture = "http://api.k780.com:88/?app=weather.future&weaid="
    let headUrlAqi = "http://api.k780.com:88/?app=weather.pm25&weaid="
    
    func startRequstWeatherData(weaid: String) {
        
        let path = headUrl + weaid + tailUrl
        
        Alamofire.request(.GET, path).responseJSON { (resultData) -> Void in
            
            let dict:NSDictionary?
            
            do {
                
                dict = try NSJSONSerialization.JSONObjectWithData(resultData.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
            }catch _ {
                
                dict = nil
                
            }
            
            if (dict != nil) {
               let result = dict!["result"] as! NSDictionary
               let def = NSUserDefaults.standardUserDefaults()
                def.setObject(result, forKey: "todayData")
                def.synchronize()
                self.delegate.reloadWeatherData()
            }
        }
    }
    
    
    func startRequstFutureWeatherData(weaid: String) {
        
        let path = headUrlFuture + weaid + tailUrl
        
        Alamofire.request(.GET, path).responseJSON { (resultData) -> Void in
            
            let dict:NSDictionary?
            
            do {
                
                dict = try NSJSONSerialization.JSONObjectWithData(resultData.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
            }catch _ {
                
                dict = nil
                
            }
            if (dict != nil) {
                let result = dict!["result"] as! NSArray
                let def = NSUserDefaults.standardUserDefaults()
                def.setObject(result, forKey: "futureData")
                def.synchronize()
                self.delegate.reloadWeatherData()
            }
        }
    }
    
    func startRequstAQIData(weaid: String) {
        let path = headUrlAqi + weaid + tailUrl
        Alamofire.request(.GET, path).responseJSON { (resultData) -> Void in
            
            let dict:NSDictionary?
            
            do {
                
                dict = try NSJSONSerialization.JSONObjectWithData(resultData.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
            }catch _ {
                
                dict = nil
                
            }
            if (dict != nil) {
                let result = dict!["result"] as! NSDictionary
                let def = NSUserDefaults.standardUserDefaults()
                def.setObject(result, forKey: "aqiData")
                def.synchronize()
                self.delegate.reloadWeatherData()
            }
        }

    }
    
    //App第一次启动时执行一次== 我本来是要将这个城市代码写到plist的，，啊啊啊西八，写不进去==
   class func startRequstCityData() {
        
        let path = "http://api.k780.com:88/?app=weather.city&&appkey=16869&sign=45ca0f2ab1e5d188c48de9c51f2497e4&format=json"
        
        Alamofire.request(.GET, path).responseJSON { (resultData) -> Void in
            
            let dict:NSDictionary?
            
            do {
                
                dict = try NSJSONSerialization.JSONObjectWithData(resultData.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
            }catch _ {
                
                dict = nil
                
            }
            
            if (dict != nil) {
                let result = dict!["result"] as! NSDictionary
            
                let def = NSUserDefaults.standardUserDefaults()
                def.setObject(result, forKey: "city")
                def.synchronize()
            }
        }
    }
    
}

