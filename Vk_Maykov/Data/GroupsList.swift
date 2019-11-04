//
//  GroupsList.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 04.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit
class GroupsList {
    static let shared = GroupsList()
    private init() {}
    var items: [GroupModel] = []
}
