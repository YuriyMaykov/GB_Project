//
//  MyGroupsCell.swift
//  Vk_Maykov
//
//  Created by Юрий on 06/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    @IBOutlet weak var myGroupNameLabel: UILabel!
    @IBOutlet weak var myGroupImage: AvatarView!
    @IBOutlet weak var preloader: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myGroupNameLabel.text = ""
        myGroupImage.image = UIImage.empty
    }
}
