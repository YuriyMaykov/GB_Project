//
//  FriendsList.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 02.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class FriendsList {
    static let shared = FriendsList()
    private init() {}
    
    var items: [FriendModel] = []
    
    func addItem(item: FriendModel) {
        items.append(item)
    }
    
    func removeItem(indx: Int) {
        guard indx >= 0 && indx < items.count else {
            return
        }
        
        items.remove(at: indx)
    }
    
    func clearItems() {
        items.removeAll()
    }
    
    func addItems(itemsArray: [FriendModel]) {
        itemsArray.forEach { item in
            items.append(item)
        }
    }
    
    
}
