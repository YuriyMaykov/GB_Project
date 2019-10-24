//
//  ExtUIImage.swift
//  Vk_Maykov
//
//  Created by Юрий on 09/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

extension UIImage {
    static var empty: UIImage {
        return UIGraphicsImageRenderer(size: CGSize.zero).image { _ in }
    }
}
