//
//  FriendCell.swift
//  Vk_Maykov
//
//  Created by Юрий on 03/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class FriendCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var preloader: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendPhoto.image = UIImage.empty
        likeCount.text = "0"
    }
}
