//
//  Session.swift
//  Vk_Maykov
//
//  Created by Юрий on 23/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class Session {
    static let shared = Session()
    private init(){}

    var token: String = ""
    var userId: String = ""
    var expiresIn: String = ""
    var userLogin: String = ""
    var userFullName: String = ""
    var userEmail: String = ""

}
