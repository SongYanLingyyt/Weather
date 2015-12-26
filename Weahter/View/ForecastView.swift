//
//  ForecastView.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/15.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit
protocol ForecastViewDelegate {
    func swipeForecastView(direction isRight: Bool)
}
class ForecastView: UIView {

    var day0: CustomView!
    var day1: CustomView!
    var day2: CustomView!
    var day3: CustomView!
    var day4: CustomView!
    var day5: CustomView!
    var day6: CustomView!
    
    var delegate: ForecastViewDelegate!
 
    let clolor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.5)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = self.clolor
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        let hh = self.frame.height / 8
        
        let titleLab = UILabel(frame: CGRectMake(10, 0, 100, hh))
        titleLab.text = "预报"
        titleLab.textColor = UIColor.whiteColor()
        self.addSubview(titleLab)
        
        let lineLab = UILabel(frame: CGRectMake(10, hh, self.frame.width - 20, 1))
        lineLab.backgroundColor = UIColor.whiteColor()
        self.addSubview(lineLab)
        
        day0 = CustomView(frame: CGRectMake(0, hh    , self.frame.width, hh))
        day1 = CustomView(frame: CGRectMake(0, hh * 2, self.frame.width, hh))
        day2 = CustomView(frame: CGRectMake(0, hh * 3, self.frame.width, hh))
        day3 = CustomView(frame: CGRectMake(0, hh * 4, self.frame.width, hh))
        day4 = CustomView(frame: CGRectMake(0, hh * 5, self.frame.width, hh))
        day5 = CustomView(frame: CGRectMake(0, hh * 6, self.frame.width, hh))
        day6 = CustomView(frame: CGRectMake(0, hh * 7, self.frame.width, hh))
        
        self.addSubview(day0)
        self.addSubview(day1)
        self.addSubview(day2)
        self.addSubview(day3)
        self.addSubview(day4)
        self.addSubview(day5)
        self.addSubview(day6)
        
        self.userInteractionEnabled = true
        
        //默认为右滑
        let swipeGesture_right = UISwipeGestureRecognizer(target: self, action: "swipeRightAction:")
        self.addGestureRecognizer(swipeGesture_right)
        //左滑
        let swipeGesture_left = UISwipeGestureRecognizer(target: self, action: "swipeLeftAction:")
        swipeGesture_left.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeGesture_left)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func upDateFutureWeather(dataArr: [WeatherResult]) {

        for i in 0...dataArr.count {
            if i == 0 {
                day0.upDateFutureWeather(dataArr[i])
            }
            if i == 1 {
                day1.upDateFutureWeather(dataArr[i])
            }
            if i == 2 {
                day2.upDateFutureWeather(dataArr[i])
            }
            if i == 3 {
                day3.upDateFutureWeather(dataArr[i])
            }
            if i == 4 {
                day4.upDateFutureWeather(dataArr[i])
            }
            if i == 5 {
                day5.upDateFutureWeather(dataArr[i])
            }
            if i == 6 {
                day6.upDateFutureWeather(dataArr[i])
            }
        }
    }
    
    //action
    func swipeLeftAction(gesture: UISwipeGestureRecognizer) {
        self.delegate.swipeForecastView(direction: false)
    }
    func swipeRightAction(gesture: UISwipeGestureRecognizer) {
        self.delegate.swipeForecastView(direction: true)
    }

    
}
