//
//  UserPhotosList.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 04.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class UserPhotosList {
    static let shared = UserPhotosList()
    private init() {}
    
    var items: [FriendPageModel] = []
}
