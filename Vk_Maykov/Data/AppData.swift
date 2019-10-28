//
//  AppData.swift
//  Vk_Maykov
//
//  Created by Юрий on 26/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class AppData {
    static let shared = AppData()
    private init(){}
   
    let vkParams:[String: Any] = [
        "scheme": "https",
        "oauth_host": "oauth.vk.com",
        "oauth_path": "/authorize",
        "params": [
            "client_id": "7183641",
            "display": "mobile",
            "redirect_uri": "https://oauth.vk.com/blank.html",
            "scope": "262150",
            "response_type": "token",
            "v": "5.68"
        ]
    ]
    
    let urlToAPI: String = ""

}
