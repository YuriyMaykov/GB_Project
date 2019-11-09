//
//  GetVkAPI.swift
//  Vk_Maykov
//
//  Created by Юрий on 27/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit
import Alamofire

class GetVKAPI {
    //https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=TOKEN&v=V

    let token = Session.shared.token
    let user_id = Session.shared.userId
    let url = "https://api.vk.com/method/"
    let verAPI = "5.102"
    
    func fetchRequest<T: Decodable>(funcUrl: String, params: [String: Any],completionHandler: @escaping(T) -> ()) {
        let rqUrl = url + funcUrl
        var rqParams: Parameters = params
        rqParams["user_id"] = (rqParams["user_id"] as? String ?? "" == "") ? user_id : rqParams["user_id"] as? String ?? ""
        rqParams["access_token"] = token
        rqParams["v"] = verAPI
        
        Alamofire.request(rqUrl, method: .post, parameters: rqParams).responseData { (data) in
            do {
                let result = try JSONDecoder().decode(T.self, from: data.data!)
                completionHandler(result)
            } catch {
                //в обработчик ошибок
                print("Ошибка при парсинге объекта JSON " + rqUrl)
                print(rqParams)
            }
        }
    }
    
    //MARK: - friends.get
    func getFriends(completionHandler: @escaping(FriendsGetModel.FriendsList) -> ()) {
        let params = [
            "user_id": user_id,
            "order": "hints",
            "fields": "nickname, photo_50, photo_100"
        ]
        let fUrl = "friends.get"
        
        fetchRequest(funcUrl: fUrl, params: params, completionHandler: completionHandler)
    }
    
    //MARK: - groups.get
    func groupsGet(_ userId: String = "", completionHandler: @escaping(GroupsGetModel.GroupsList) -> ()) {
        let fUrl = "groups.get"
        let params = [
            "user_id": (userId == "" ? user_id : userId),
            "extended": "1"
        ]
        
        fetchRequest(funcUrl: fUrl, params: params, completionHandler: completionHandler)
    }

    //MARK: - photos.getAll
    func photosGetAll(ownerId: String = "", offset: Int = 0, count: Int = 20, completionHandler: @escaping(PhotosGetAllModel.UserPhotosList) -> ()) {
        let fUrl = "photos.getAll"
        let params: Parameters = [
            "owner_id": (ownerId == "" ? user_id : ownerId),
            "extended": 1,
            "offset": offset,
            "count": count,
            "photo_sizes": 1
        ]
        
        fetchRequest(funcUrl: fUrl, params: params, completionHandler: completionHandler)
    }
    
    /*
    func groupsSearch(q: String, type: String = "", sort: Int = 0, offset: Int = 0, count: Int = 20) {
        let methodName = "groups.search"

        var params = [
            "q": q,
            "sort": String(sort),
            "offset": String(offset),
            "count": String(count)
        ]
        if !type.isEmpty {
            params["type"] = type
        }
    
    }
     
   */
    
}
