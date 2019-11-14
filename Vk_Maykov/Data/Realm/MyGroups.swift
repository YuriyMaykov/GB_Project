//
//  MyGroups.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 14.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import Foundation
import RealmSwift

class MyGroups: Object {
    @objc dynamic var groupId = 0
    @objc dynamic var groupName = ""
    @objc dynamic var groupDesc = ""
    @objc dynamic var urlImgSmall = ""
}
