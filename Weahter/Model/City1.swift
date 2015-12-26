//
//	City1.swift
//
//	Create by 网络 岚海 on 17/12/2015
//	Copyright © 2015. All rights reserved.
//	

import Foundation
//import SwiftyJSON

struct City1{

	var cityid : String!
	var citynm : String!
	var cityno : String!
	var weaid : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
   
    init(fromJson json: AnyObject){
//        cityid = json["cityid"].string
//        citynm = json["citynm"].string
//        cityno = json["cityno"].string
//        weaid  = json["weaid"].string
        cityid = json.valueForKey("cityid") as! String
        citynm = json.valueForKey("citynm") as! String
        cityno = json.valueForKey("cityno") as! String
        weaid  = json.valueForKey("weaid") as! String
        
    }

}