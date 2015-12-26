//
//  AQIView.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/22.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class AQIView: UIView {

    var cityLabel: UILabel!     //城市
    var apiLabel:  UILabel!     //空气质量指数
    var apiLevel:  UILabel!     //空气污染程度
    var apiScope:  UILabel!     //空气质量指数范围
    var apiMark:   UILabel!     //温馨提示
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let hh = self.frame.height / 5
        let ww = self.frame.width / 2
        
        self.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.5)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        let titleLabel = UILabel(frame: CGRectMake(10, 0, 150, hh))
        titleLabel.text = "空气质量指数"
        titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(titleLabel)
        
        let lineLab = UILabel(frame: CGRectMake(10, hh, self.frame.width - 20, 1))
        lineLab.backgroundColor = UIColor.whiteColor()
        self.addSubview(lineLab)
        
        self.cityLabel = UILabel(frame: CGRectMake(self.frame.width - 160, 0, 150, hh))
        self.cityLabel.textColor = UIColor.whiteColor()
        self.cityLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(self.cityLabel)
        
        let titleArr = ["空气质量指数：", "空气污染程度：", "空气质量指数范围：", "温馨提示："]
        
        for i in 0 ... 3 {
        
            let mApiLab = UILabel(frame: CGRectMake(0, hh * CGFloat(i + 1), ww - 20, hh))
            mApiLab.font = UIFont.systemFontOfSize(14)
            mApiLab.text =  titleArr[i]
            mApiLab.textColor = UIColor.whiteColor()
            mApiLab.textAlignment = NSTextAlignment.Right
            self.addSubview(mApiLab)
        }
        
        self.apiLabel = UILabel(frame: CGRectMake(ww - 20, hh, ww, hh))
        self.apiLabel.textColor = UIColor.whiteColor()
        self.apiLabel.font = UIFont.systemFontOfSize(12)
        self.addSubview(self.apiLabel)
        
        self.apiLevel = UILabel(frame: CGRectMake(ww - 20, hh * 2, ww, hh))
        self.apiLevel.textColor = UIColor.whiteColor()
        self.apiLevel.font = UIFont.systemFontOfSize(12)
        self.addSubview(self.apiLevel)
        
        self.apiScope = UILabel(frame: CGRectMake(ww - 20, hh * 3, ww, hh))
        self.apiScope.textColor = UIColor.whiteColor()
        self.apiScope.font = UIFont.systemFontOfSize(12)
        self.addSubview(self.apiScope)
        
        self.apiMark = UILabel(frame: CGRectMake(ww - 20, hh * 4, ww, hh))
        self.apiMark.textColor = UIColor.whiteColor()
        self.apiMark.font = UIFont.systemFontOfSize(12)
        self.addSubview(self.apiMark)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAPIData(data: APIData) {
        
        self.apiLabel.text = data.api
        self.cityLabel.text = data.cityName
        self.apiLevel.text = data.apiLevel
        self.apiScope.text = data.apiScope
        self.apiMark.text = data.apiMark
    }
    
}
