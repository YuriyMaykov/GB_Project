//
//  UserPhotos.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 12.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import Foundation
import RealmSwift

class UserPhotos: Object {
    @objc dynamic var itemId = 0
    @objc dynamic var userId = 0
    @objc dynamic var likesCount = 0
    @objc dynamic var notis = ""
    @objc dynamic var urlSmalPhoto = ""
    @objc dynamic var urlBigPhoto = ""
}
