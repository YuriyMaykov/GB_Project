//
//  User.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 10.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var userId = 0
    @objc dynamic var userName = ""
    @objc dynamic var urlImgSmall = ""
    @objc dynamic var urlImgBig = ""
    @objc dynamic var userEmail = ""
}
