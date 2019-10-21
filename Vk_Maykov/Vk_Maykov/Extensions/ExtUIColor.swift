//
//  ExtUIColor.swift
//  Vk_Maykov
//
//  Created by Юрий on 09/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

extension UIColor {
    
    fileprivate convenience init(redInt: Int, greenInt: Int, blueInt: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat(redInt) / 255.0,
            green: CGFloat(greenInt) / 255.0,
            blue: CGFloat(blueInt) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1)
    }
    
    convenience init(hex: Int, alpha: CGFloat) {
        self.init(
            redInt: (hex >> 16) & 0xff,
            greenInt: (hex >> 8) & 0xff,
            blueInt: hex & 0xff,
            alpha: alpha
        )
    }
    
}
