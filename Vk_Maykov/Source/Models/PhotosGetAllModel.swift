//
//  PhotosGetAllModel.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 04.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class PhotosGetAllModel: Decodable {
    struct userPhotosList: Decodable {
        let response: responseHead
    }

    struct responseHead: Decodable {
        let count: Int
        let items: [photosItems]
    }
    
    struct photosItems: Decodable {
        let id: Int
        let albumId: Int?
        let ownerId: Int?
        let sizes: [photoSizes]
        let text: String?
        //let date: Date?
        //let postId: Int
        let likes: photoLikes
        let reposts: photoReposts
        
        enum CodingKeys: String, CodingKey {
            case id
            case albumId = "album_id"
            case ownerId = "owner_id"
            case sizes
            case text
            //case date
            //case postId = "post_id"
            case likes
            case reposts
        }
    }
    
    struct photoSizes: Decodable {
        let type: String
        let url: String
        let width: Int
        let height: Int
    }
    
    struct photoLikes: Decodable {
        let userLikes: Int
        let likesCount: Int
        
        enum CodingKeys: String, CodingKey {
            case userLikes = "user_likes"
            case likesCount = "count"
        }
    }
    
    struct photoReposts: Decodable {
        let repostsCount: Int
        
        enum CodingKeys: String, CodingKey {
            case repostsCount = "count"
        }
    }
    /*
     
     "likes": {
         "user_likes": 0,
         "count": 0
     },

     {
         "response": {
             "count": 1,
             "items": [
                 {
                     "id": 456239025,
                     "album_id": -6,
                     "owner_id": 455964034,
                     "sizes": [
                         {
                             "type": "m",
                             "url": "https://sun9-32.userapi.com/c851332/v851332835/a94b6/JYdL76sPymU.jpg",
                             "width": 111,
                             "height": 130
                         },
                         {
                             "type": "o",
                             "url": "https://sun9-52.userapi.com/c851332/v851332835/a94b8/RXbKjF1ct0M.jpg",
                             "width": 130,
                             "height": 152
                         },
                         {
                             "type": "p",
                             "url": "https://sun9-71.userapi.com/c851332/v851332835/a94b9/PSZt8xLqzXY.jpg",
                             "width": 200,
                             "height": 234
                         },
                         {
                             "type": "q",
                             "url": "https://sun9-28.userapi.com/c851332/v851332835/a94ba/cqwbJcys5q4.jpg",
                             "width": 247,
                             "height": 289
                         },
                         {
                             "type": "r",
                             "url": "https://sun9-70.userapi.com/c851332/v851332835/a94bb/EXK8EmhBr2I.jpg",
                             "width": 247,
                             "height": 289
                         },
                         {
                             "type": "s",
                             "url": "https://sun9-29.userapi.com/c851332/v851332835/a94b5/8AxNJeJxvFg.jpg",
                             "width": 64,
                             "height": 75
                         },
                         {
                             "type": "x",
                             "url": "https://sun9-20.userapi.com/c851332/v851332835/a94b7/JgfkLN21Hdo.jpg",
                             "width": 247,
                             "height": 289
                         }
                     ],
                     "text": "",
                     "date": 1549253035,
                     "post_id": 4,
                     "likes": {
                         "user_likes": 0,
                         "count": 0
                     },
                     "reposts": {
                         "count": 0
                     }
                 }
             ]
         }
     }
     
     
     
     
     */
}
