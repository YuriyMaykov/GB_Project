//
//  AllGroupsCell.swift
//  Vk_Maykov
//
//  Created by Юрий on 06/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class AllGroupsCell: UITableViewCell {
    @IBOutlet weak var allGroupsNameLabel: UILabel!
    @IBOutlet weak var allGroupsImage: AvatarView!
    @IBOutlet weak var preloader: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        allGroupsNameLabel.text = ""
        allGroupsImage.image = UIImage.empty
    }
}
