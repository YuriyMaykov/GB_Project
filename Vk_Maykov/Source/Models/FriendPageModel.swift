//
//  FriendPageModel.swift
//  Vk_Maykov
//
//  Created by Юрий on 11/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class FriendPageModel {
    var itemId: Int
    var userId: Int
    var itemImage: UIImage?
    var likesCount: Int
    var notis: String
    
    init(itemId: Int, userId: Int, itemImage: UIImage, likesCount: Int, notis: String) {
        self.itemId = itemId
        self.userId = userId
        self.itemImage = itemImage
        self.likesCount = likesCount
        self.notis = notis
    }
}
