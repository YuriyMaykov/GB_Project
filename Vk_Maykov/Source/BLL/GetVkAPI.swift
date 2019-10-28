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

    func friendsGet() {
        let methodName = "friends.get"
        let params = [
            "user_id": user_id,
            "order": "hints",
            "fields": "nickname, domain, sex, bdate, city, country, photo_50"
        ]
        getRequestData(url + methodName, .post, params, methodName)
    }

    func photosGetAll(_ ownerId: String = "") {
        let methodName = "photos.getAll"
        let params = [
            "owner_id": ownerId,
            "extended": "1",
            "photo_sizes": "1"
        ]
        getRequestData(url + methodName, .post, params, methodName)
    }
    
    func groupsGet(_ userId: String = "") {
        let methodName = "groups.get"

        let params = [
            "user_id": (userId == "" ? user_id : userId),
            "extended": "1"
        ]
 
        getRequestData(url + methodName, .post, params, methodName)
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
    
        getRequestData(url + methodName, .post, params, methodName)
    }

    
    func getRequestData(_ url: String,_ method: HTTPMethod,_ params: Parameters,_ methodName: String = "") {
        var params = params as Parameters
        params["access_token"] = token
        params["v"] = "5.102"

        Alamofire.request(url, method: method, parameters: params).responseJSON { response in
            print("!!!!!!! " + methodName)
            print(response.value ?? "Запрос не вернул данные!")
        }

    }
}
