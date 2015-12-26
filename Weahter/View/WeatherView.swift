//
//  WeatherView.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/11.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit
protocol WeatherViewDelegate {
    func swipeWeatherView(direction isRight: Bool)   //滑动手势
}
class WeatherView: UIView {
 
    var locationLabel: UILabel!
    var currentTemperatureLabel: UILabel!
    var timeLabel: UILabel!
    var humidityLabel: UILabel!
    var infoLabel: UILabel!
    var windLabel: UILabel!
    var iconImageView: UIImageView!
    var subWeatherView: UIView!
    var delegate: WeatherViewDelegate!
    
    let clolor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        self.currentTemperatureLabel = UILabel(frame: CGRectMake(self.frame.width - 250, self.frame.height / 2 - 100, 250, 100))
        self.currentTemperatureLabel.textColor = UIColor.whiteColor()
        self.currentTemperatureLabel.font = UIFont.systemFontOfSize(80)
        self.currentTemperatureLabel.textAlignment = NSTextAlignment.Right
//        self.currentTemperatureLabel.text = "18"
        self.addSubview(self.currentTemperatureLabel)
        
        self.subWeatherView = UIView(frame: CGRectMake(0, self.frame.height - self.frame.width / 2, self.frame.width, self.frame.width / 2))
        self.subWeatherView.backgroundColor = self.clolor
        self.subWeatherView.layer.cornerRadius = 10
        self.subWeatherView.clipsToBounds = true
        self.addSubview(self.subWeatherView)
        
        let hh = self.subWeatherView.frame.height / 5
        
        let titleLabel = UILabel(frame: CGRectMake(10, 0, 100, hh))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "今天"
        self.subWeatherView.addSubview(titleLabel)
        
        let lineLabel = UILabel(frame: CGRectMake(10, hh, self.frame.width - 20, 1))
        lineLabel.backgroundColor = UIColor.whiteColor()
        self.subWeatherView.addSubview(lineLabel)
        
        self.timeLabel = UILabel(frame: CGRectMake(self.frame.width - 100, 0, 100, hh))
        self.timeLabel.textColor = UIColor.whiteColor()
        self.subWeatherView.addSubview(self.timeLabel)
        
        self.iconImageView = UIImageView(frame: CGRectMake(20, hh + hh / 2, hh * 3, hh * 3))
        self.subWeatherView.addSubview(self.iconImageView)
        
        self.locationLabel = UILabel(frame: CGRectMake(self.frame.width - 150, hh, 150, hh))
        self.locationLabel.textColor = UIColor.whiteColor()
        self.subWeatherView.addSubview(self.locationLabel)
        
        self.infoLabel = UILabel(frame: CGRectMake(self.frame.width - 150, hh * 2, 150, hh))
        self.infoLabel.textColor = UIColor.whiteColor()
        self.subWeatherView.addSubview(self.infoLabel)
        
        self.windLabel = UILabel(frame: CGRectMake(self.frame.width - 150, hh * 3, 150, hh))
        self.windLabel.textColor = UIColor.whiteColor()
        self.subWeatherView.addSubview(self.windLabel)
        
        self.humidityLabel = UILabel(frame: CGRectMake(self.frame.width - 150, hh * 4, 150, hh))
        self.humidityLabel.textColor = UIColor.whiteColor()
        self.subWeatherView.addSubview(self.humidityLabel)

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

    func upDateWeatherViewDate(data: WeatherResult) {
        
        self.currentTemperatureLabel.text = data.temperatureCurr
        self.timeLabel.text = data.days
        self.locationLabel.text = data.citynm
        self.infoLabel.text = data.weather + "/" + data.temperature
        self.windLabel.text = data.wind + "/" + data.winp
        self.humidityLabel.text = "湿度/" + data.humidity
        
        let url = NSURL(string: data.weatherIcon)
        let dataImage = NSData(contentsOfURL: url!)
        if dataImage != nil {
            self.iconImageView.image = UIImage(data: dataImage!)
        }
    }
    
    //action
    func swipeLeftAction(gesture: UISwipeGestureRecognizer) {
        self.delegate.swipeWeatherView(direction: false)
    }
    func swipeRightAction(gesture: UISwipeGestureRecognizer) {
        self.delegate.swipeWeatherView(direction: true)
    }
}
