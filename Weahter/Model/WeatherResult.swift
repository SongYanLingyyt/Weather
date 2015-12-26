//
//	WeatherResult.swift
//
//	Create by 网络 岚海 on 17/12/2015
//	Copyright © 2015. All rights reserved.
//	

import Foundation

struct WeatherResult{

	var cityid : String!
	var citynm : String!
	var cityno : String!
	var days : String!
	var humiHigh : String!
	var humiLow : String!
	var humidity : String!
	var tempCurr : String!
	var tempHigh : String!
	var tempLow : String!
	var temperature : String!
	var temperatureCurr : String!
	var weaid : String!
	var weather : String!
	var weatherIcon : String!
	var weatherIcon1 : String!
	var weatid : String!
	var weatid1 : String!
	var week : String!
	var wind : String!
	var windid : String!
	var winp : String!
	var winpid : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		cityid = dictionary["cityid"] as? String
		citynm = dictionary["citynm"] as? String
		cityno = dictionary["cityno"] as? String
		days = dictionary["days"] as? String
		humiHigh = dictionary["humi_high"] as? String
		humiLow = dictionary["humi_low"] as? String
		humidity = dictionary["humidity"] as? String
		tempCurr = dictionary["temp_curr"] as? String
		tempHigh = dictionary["temp_high"] as? String
		tempLow = dictionary["temp_low"] as? String
		temperature = dictionary["temperature"] as? String
		temperatureCurr = dictionary["temperature_curr"] as? String
		weaid = dictionary["weaid"] as? String
		weather = dictionary["weather"] as? String
		weatherIcon = dictionary["weather_icon"] as? String
		weatherIcon1 = dictionary["weather_icon1"] as? String
		weatid = dictionary["weatid"] as? String
		weatid1 = dictionary["weatid1"] as? String
		week = dictionary["week"] as? String
		wind = dictionary["wind"] as? String
		windid = dictionary["windid"] as? String
		winp = dictionary["winp"] as? String
		winpid = dictionary["winpid"] as? String
	}
    
    
}