//
//  DataManager.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 10.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit
import RealmSwift

class DataManager {
    
    //MARK: - manage User data
    
    func getUsers() -> Bool {
        var res = false
        var friendsList = FriendsList.shared.items.sorted(by: {$0.userName < $1.userName})
        friendsList.removeAll()
        do {
            let realmItems = try Realm().objects(User.self)
            if realmItems.count > 0 {
                for item in realmItems {
                    friendsList.append(
                        FriendModel(
                            userId: item.userId,
                            userName: item.userName,
                            userAvatar: UIImage.empty,
                            urlImgSmall: item.urlImgSmall,
                            urlImgBig: item.urlImgBig,
                            userEmail: ""
                        )
                    )
                }
            }
            res = true
        } catch {
            print(error)
            res = false
        }
        return res
    }
    
    func clearUsers() -> Bool {
        var res = false
        do {
            let realm  = try Realm()
            try realm.write {
                let realmItemsDelet = realm.objects(User.self)
                realm.delete(realmItemsDelet)
            }
            res = true
        } catch {
            print(error)
            res = false
        }
        return res
    }
    
    func setUsers(items: [FriendModel]) -> Bool {
        var res = false
        if clearUsers() {
            if items.count > 0 {
                do {
                    let realm = try Realm()
                    try realm.write {
                        for item in items {
                            let realmItems = User()
                            realmItems.userName = item.userName
                            realmItems.userId = item.userId
                            realmItems.urlImgSmall = item.urlImgSmall
                            realmItems.urlImgBig = item.urlImgBig
                            realm.add(realmItems)
                        }
                    }
                } catch {
                    print(error)
                    res = false
                }
            }
            res = true
        } else {
            res = false
        }
        return res
    }
    
    
    //MARK: - manage UserPhotos data
    
    func getUserPhotos(ownerId: Int) -> Bool {
        var res = false
        if ownerId == 0 {
            return res
        }
        var userPhotoList = UserPhotosList.shared.items
        userPhotoList.removeAll()
        do {
            let realmItems = try Realm().objects(UserPhotos.self).filter("userId = " + String(ownerId))
            if realmItems.count > 0 {
                for item in realmItems {
                    userPhotoList.append(
                        FriendPageModel(
                            itemId: item.itemId,
                            userId: item.userId,
                            itemImage: UIImage.empty,
                            likesCount: item.likesCount,
                            notis: item.notis,
                            urlSmalPhoto: item.urlSmalPhoto,
                            urlBigPhoto: item.urlBigPhoto
                        )
                    )
                }
            }
            res = true
        } catch {
            print(error)
            res = false
        }
        return res
    }
    
    func clearUserPhotos(_ ownerId: Int = -1) -> Bool {
        var res = false
        do {
            let realm  = try Realm()
            try realm.write {
                var realmItemsDelete = realm.objects(UserPhotos.self).filter("userId = " + String(ownerId))
                if ownerId == -1 {
                    realmItemsDelete = realm.objects(UserPhotos.self)
                }
                realm.delete(realmItemsDelete)
            }
            res = true
        } catch {
            print(error)
            res = false
        }
        return res
    }
    
    func setUserPhotos(items: [FriendPageModel], _ ownerId: Int) -> Bool {
        var res = false
        if ownerId == 0 {
            return res
        }
        if clearUserPhotos(ownerId) {
            if items.count > 0 {
                do {
                    let realm = try Realm()
                    try realm.write {
                        for item in items {
                            let realmItems = UserPhotos()
                            realmItems.itemId = item.itemId
                            realmItems.userId = item.userId
                            realmItems.likesCount = item.likesCount
                            realmItems.notis = item.notis
                            realmItems.urlSmalPhoto = item.urlSmalPhoto
                            realmItems.urlBigPhoto = item.urlBigPhoto
                            realm.add(realmItems)
                        }
                    }
                } catch {
                    print(error)
                    res = false
                }
            }
            res = true
        } else {
            res = false
        }
        return res
    }
    
    
    //MARK: - manage MyGroups data
    
    func getMyGroups() -> Bool {
        var res = false
        var groupsList = GroupsList.shared.items.sorted(by: {$0.groupName < $1.groupName})
        groupsList.removeAll()
        do {
            let realmItems = try Realm().objects(MyGroups.self)
            if realmItems.count > 0 {
                for item in realmItems {
                    groupsList.append(GroupModel(
                        groupId: item.groupId,
                        groupName: item.groupName,
                        groupImage: UIImage.empty,
                        groupDesc: item.groupDesc,
                        groupImgUrl: item.urlImgSmall
                        )
                    )
                }
            }
            res = true
        } catch {
            print(error)
            res = false
        }
        return res
    }
    
    func clearMyGroups() -> Bool {
        var res = false
        do {
            let realm  = try Realm()
            try realm.write {
                let realmItemsDelet = realm.objects(MyGroups.self)
                realm.delete(realmItemsDelet)
            }
            res = true
        } catch {
            print(error)
            res = false
        }
        return res
    }
    
    func setMyGroups(items: [GroupModel]) -> Bool {
        var res = false
        if clearUsers() {
            if items.count > 0 {
                do {
                    let realm = try Realm()
                    try realm.write {
                        for item in items {
                            let realmItems = MyGroups()
                            realmItems.groupId = item.groupId
                            realmItems.groupName = item.groupName
                            realmItems.groupDesc = item.groupDesc
                            realmItems.urlImgSmall = item.groupImgUrl
                            realm.add(realmItems)
                        }
                    }
                } catch {
                    print(error)
                    res = false
                }
            }
            res = true
        } else {
            res = false
        }
        return res
    }
    
    

    
    
    //MARK: - загрузка изображения по URL с кэшированием
    var imgCache = NSCache<NSString, UIImage>()
    func downLoadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imgCache.object(forKey: url.absoluteString as NSString){
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                
                guard error == nil,
                    data != nil,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let `self` = self else {
                        return
                }
                
                guard let image = UIImage(data: data!) else { return }
                self.imgCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
            
        }
    }
    
    
    
}
