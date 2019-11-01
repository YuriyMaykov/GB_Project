//
//  DataManager.swift
//  Vk_Maykov
//
//  Created by Юрий on 31/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class DataManager {
    //MARK: - формирование данных списка друзей
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

    //getVkAPI.getFriends { qResult in print(qResult) }

    func friendsConvertData() {
        let getAPI = GetVKAPI()
        getAPI.getFriends { qResult in
            guard let items:[ParsModels.items] = qResult.response.items else {
                print("Ошибка. Нет массива с данными!")
                return
            }
            
            if items.count > 0 {
                for item in items {
                    print(item.id)
                    print(item.lastName ?? " -- ")
                    print(item.firstName ?? " -- ")
                    print(item.photo50 ?? " -- ")

                    self.addItem(friendItem: FriendModel(
                        userId: item.id,
                        userName: (item.lastName ?? "") + " " + (item.firstName ?? ""),
                        userAvatar: UIImage.empty,
                        userEmail: ""
                        )
                    )
                    print(self.friends[0].userName)
                }
                
            }
            
        }
    }
    
}
