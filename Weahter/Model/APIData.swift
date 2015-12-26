//
//  APIData.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/22.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class APIData: NSObject {

    var cityName: String!
    var api: String!
    var apiLevel: String!
    var apiScope: String!
    var apiMark: String!
    
    init(fromDictionary dict:NSDictionary) {
        cityName = dict["citynm"] as! String
        api = dict["aqi"] as! String
        apiLevel = dict["aqi_levnm"] as! String
        apiScope = dict["aqi_scope"] as! String
        apiMark = dict["aqi_remark"] as! String
    }
    
}
