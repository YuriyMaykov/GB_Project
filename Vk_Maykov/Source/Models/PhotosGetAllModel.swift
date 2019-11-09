//
//  PhotosGetAllModel.swift
//  Vk_Maykov
//
//  Created by ТПлюс on 04.11.2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class PhotosGetAllModel: Decodable {
    struct UserPhotosList: Decodable {
        let response: ResponseHead
    }

    struct ResponseHead: Decodable {
        let count: Int
        let items: [PhotosItems]
    }
    
    struct PhotosItems: Decodable {
        let id: Int
        let albumId: Int?
        let ownerId: Int?
        let sizes: [PhotoSizes]
        let text: String?
        //let date: Date?
        //let postId: Int
        let likes: PhotoLikes
        let reposts: PhotoReposts
        
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
    
    struct PhotoSizes: Decodable {
        let type: String
        let url: String
        let width: Int
        let height: Int
    }
    
    struct PhotoLikes: Decodable {
        let userLikes: Int
        let likesCount: Int
        
        enum CodingKeys: String, CodingKey {
            case userLikes = "user_likes"
            case likesCount = "count"
        }
    }
    
    struct PhotoReposts: Decodable {
        let repostsCount: Int
        
        enum CodingKeys: String, CodingKey {
            case repostsCount = "count"
        }
    }
}
