//
//  DataManager.swift
//  Vk_Maykov
//
//  Created by Юрий on 13/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

public class DataManager {
    func getFriends(){
        let friends = Friends.shared

        // получение данных списка друзей
        // тут мы идем на сервер и получаем данные
        let data: [FriendModel] = [
            FriendModel(userId: 1, userName: "Щеголев Петр Сергеевич", userAvatar: UIImage(named: "user1")!, userEmail: "user1@uasersmail.ru"),
            FriendModel(userId: 2, userName: "Петренко Николай", userAvatar: UIImage(named: "user2")!, userEmail: "user2@uasersmail.ru"),
            FriendModel(userId: 3, userName: "Василий Журавликов", userAvatar: UIImage(named: "user3")!, userEmail: "user3@uasersmail.ru"),
            FriendModel(userId: 11, userName: "Некто неизвестный", userAvatar: UIImage(named: "Noimage")!, userEmail: "user11@uasersmail.ru"),
            FriendModel(userId: 4, userName: "User4", userAvatar: UIImage(named: "user4")!, userEmail: "user4@uasersmail.ru"),
            FriendModel(userId: 5, userName: "User5", userAvatar: UIImage(named: "user5")!, userEmail: "user5@uasersmail.ru"),
            FriendModel(userId: 6, userName: "User6", userAvatar: UIImage(named: "user6")!, userEmail: "user6@uasersmail.ru"),
            FriendModel(userId: 7, userName: "User7", userAvatar: UIImage(named: "user7")!, userEmail: "user7@uasersmail.ru"),
            FriendModel(userId: 8, userName: "User8", userAvatar: UIImage(named: "user8")!, userEmail: "user8@uasersmail.ru"),
            FriendModel(userId: 9, userName: "User9", userAvatar: UIImage(named: "user9")!, userEmail: "user9@uasersmail.ru"),
            FriendModel(userId: 10, userName: "User10", userAvatar: UIImage(named: "user10")!, userEmail: "user10@uasersmail.ru")
        ]
        
        friends.addItems(friendArray: data)
    }
}
