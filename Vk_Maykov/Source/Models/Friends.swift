//
//  Friends.swift
//  Vk_Maykov
//
//  Created by Юрий on 23/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class Friends {
    static let shared = Friends()
    private init() {}
    var friends:[FriendModel] = []
    
    func addItem(friendItem: FriendModel) {
        friends.append(friendItem)
    }
    
    func addItems(friendArray: [FriendModel]) {
        friendArray.forEach { item in
            friends.append(item)
        }
    }
    
    func removeItem(indx: Int) {
        friends.remove(at: indx)
    }
    
    func clearAll() {
        friends.removeAll()
    }
}
