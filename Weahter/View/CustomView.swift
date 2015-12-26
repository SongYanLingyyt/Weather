//
//  CustomView.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/17.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class CustomView: UIView {

    var weekLab: UILabel!
    var iconImageView: UIImageView!
    var iconImageView1: UIImageView!
    var highTempratureLab: UILabel!
    var lowTemperatureLab: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.weekLab = UILabel(frame: CGRectMake(10, 0, self.frame.width / 3, self.frame.height))
        self.weekLab.textColor = UIColor.whiteColor()
        self.addSubview(self.weekLab)
        
        self.iconImageView = UIImageView(frame: CGRectMake((self.frame.width - self.frame.height) / 2, self.frame.height / 4, self.frame.height / 2, self.frame.height / 2))
        self.iconImageView.clipsToBounds = true
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width / 2
        self.addSubview(self.iconImageView)
        
        self.iconImageView1 = UIImageView(frame: CGRectMake((self.frame.width - self.frame.height) / 2 + self.frame.height / 2 + 5, self.frame.height / 4, self.frame.height / 2, self.frame.height / 2))
        self.iconImageView1.clipsToBounds = true
        self.iconImageView1.layer.cornerRadius = self.iconImageView1.frame.width / 2
        self.addSubview(self.iconImageView1)

        self.highTempratureLab = UILabel(frame: CGRectMake(self.frame.width - 50, 0, 50, self.frame.height))
        self.highTempratureLab.textColor = UIColor.whiteColor()
        self.addSubview(self.highTempratureLab)
        
        self.lowTemperatureLab = UILabel(frame: CGRectMake(self.frame.width - 50 * 2, 0, 50, self.frame.height))
        self.lowTemperatureLab.textColor = UIColor.blueColor()
        self.addSubview(self.lowTemperatureLab)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func upDateFutureWeather(data: WeatherResult) {
        
        self.weekLab.text = data.week
        self.highTempratureLab.text = data.tempHigh
        self.lowTemperatureLab.text = data.tempLow
        let url = NSURL(string: data.weatherIcon)
        let url1 = NSURL(string: data.weatherIcon1)
        let imageData = NSData(contentsOfURL: url!)
        let imageData1 = NSData(contentsOfURL: url1!)
        self.iconImageView.image = UIImage(data: imageData!, scale: 1.0)
        self.iconImageView1.image = UIImage(data: imageData1!, scale: 1.0)
        
    }
}
