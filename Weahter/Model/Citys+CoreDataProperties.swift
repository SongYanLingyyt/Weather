//
//  Citys+CoreDataProperties.swift
//  Weahter
//
//  Created by 岚海网络 on 15/12/21.
//  Copyright © 2015年 岚海网络. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Citys {

    @NSManaged var cityid: String?
    @NSManaged var citynm: String?
    @NSManaged var cityno: String?
    @NSManaged var weaid: String?
    @NSManaged var temperature: String?
    @NSManaged var weatherIcon: String?
}
