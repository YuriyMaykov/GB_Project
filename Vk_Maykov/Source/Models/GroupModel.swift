//
//  GroupModel.swift
//  Vk_Maykov
//
//  Created by Юрий on 03/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class GroupModel{
    var groupId: Int
    var groupName: String
    var groupImage: UIImage?
    var groupDesc: String
    
    init(groupId: Int, groupName: String, groupImage: UIImage, groupDesc: String) {
        self.groupId = groupId
        self.groupName = groupName
        self.groupImage = groupImage
        self.groupDesc = groupDesc
    }
}
