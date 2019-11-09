//
//  GroupsGetModel.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 04.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit
class GroupsGetModel: Decodable {
    struct GroupsList: Decodable {
        let response: ResponseHead
    }
    
    struct ResponseHead: Decodable {
        let count: Int
        let items: [GroupsItems]
    }
    
    struct GroupsItems: Decodable {
        let id: Int
        var groupName: String?
        var isClosed: Int?
        var photo50: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case groupName = "name"
            case isClosed = "is_closed"
            case photo50 = "photo_50"
        }
    }
}
