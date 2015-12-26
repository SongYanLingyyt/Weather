//
//  CityData.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/17.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class CityData: NSObject {

//    var CityArr: [City1]!
//    
//    class func shareCity() ->CityData {
//        
//        struct temps {
//            static var instance: CityData?
//            static var myT:dispatch_once_t = 0
//        }
//        //线程安全
//        dispatch_once(&temps.myT, { () -> Void in
//            temps.instance = CityData.init()
//        })
//
//        return temps.instance!
//    }
//    
//    override init() {
//        self.CityArr = []
//    }
    
    //通过城市名字获取城市代码
    class func fetchCityCode(cityName: String) -> String {
        
        var weaid: String!
        
        let def = NSUserDefaults.standardUserDefaults()
        
        let rootDic = def.objectForKey("city") as! NSDictionary
        
        for element in rootDic {
            
            let cityno = element.value.valueForKey!("cityno") as! String
            
            let citynm = element.value.valueForKey!("citynm") as! String
            
            if citynm == cityName || cityno == cityName {
            
                weaid = element.value.valueForKey!("weaid") as! String
                
            }
        }
         return weaid
    }
    
    class func searchCity(cityName: String) -> [City1] {
        
        var cityArr: [City1] = []
        
        let def = NSUserDefaults.standardUserDefaults()
        
        let rootDic = def.objectForKey("city") as! NSDictionary
        
        for element in rootDic {
            
            let cityno = element.value.valueForKey!("cityno") as! String
            let citynm = element.value.valueForKey!("citynm") as! String
            
            let subnm = (citynm as NSString).containsString(cityName)
            let subno = (cityno as NSString).containsString(cityName)
            
            if subnm == true || subno == true {
                let city = City1(fromJson: element.value)
                cityArr.append(city)
            }
        }
        return cityArr
    }
    
    
}
