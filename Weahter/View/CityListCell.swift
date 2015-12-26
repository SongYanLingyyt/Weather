//
//  CityListCell.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/21.
//  Copyright © 2015年 岚海网络. All rights reserved.
//

import UIKit

class CityListCell: UITableViewCell {



    @IBOutlet weak var cityNmLab: UILabel!
    
    @IBOutlet weak var temperatureLab: UILabel!
   
    @IBOutlet weak var iconImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.clipsToBounds = true
        self.iconImageView.layer.cornerRadius = 15
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
