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

    //MARK: - friends.get
    func getFriends(completionHandler: @escaping(ParsModels.friendsList) -> ()) {
        //var rqPrm = friendsGet()
        let params = [
            "user_id": user_id,
            "order": "hints",
            "fields": "nickname, photo_50, photo_100",
            "access_token": token,
            "v": "5.102"
        ]
        let fUrl = url + "friends.get"
        
        Alamofire.request(fUrl, method: .post, parameters: params).responseData { (data) in
            let parsModel = ParsModels.friendsList.self
            do {
                let result = try JSONDecoder().decode(parsModel, from: data.data!)
                completionHandler(result)
            } catch {
                //в обработчик ошибок
                print("Ошибка при парсинге объекта JSON")
            }
        }

    }

    /*
    //struct requestComponents { var url: String; var params: Parameters; }
    func friendsGet() -> requestComponents {
        return requestComponents(
            url: url + "friends.get",
            params: ["user_id": user_id,
                     "order": "hints",
                     "fields": "nickname, photo_50, photo_100"
                    ]
        )
    }
    */
    
    func photosGetAll(_ ownerId: String = "") {
        let methodName = "photos.getAll"
        let params = [
            "owner_id": ownerId,
            "extended": "1",
            "photo_sizes": "1"
        ]
    }
    
    func groupsGet(_ userId: String = "") {
        let methodName = "groups.get"

        let params = [
            "user_id": (userId == "" ? user_id : userId),
            "extended": "1"
        ]
 
    }
    
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
   
    
}
