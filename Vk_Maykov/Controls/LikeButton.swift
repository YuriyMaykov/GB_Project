//
//  LikeButton.swift
//  Vk_Maykov
//
//  Created by Юрий on 10/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class  LikeButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let maskLayer = CAShapeLayer()
        let paht = UIBezierPath()
        let h = bounds.height
        let w = bounds.width
        let p0: CGPoint = CGPoint(x: w / 2 , y: h * 0.9)
        let leftCenter: CGPoint = CGPoint(x: w * 0.34, y: h * 0.4)
        let rightCenter: CGPoint = CGPoint(x: w * 0.66, y: h * 0.4)
        let radius: CGFloat = CGFloat(w * 0.24)
        let startAngle: CGFloat = CGFloat(2.3)
        let endAngle: CGFloat = CGFloat(0.8)
        //let clockwise: Bool = true
        
        paht.move(to: p0)
        paht.addArc(withCenter: leftCenter, radius: radius, startAngle: startAngle, endAngle: -endAngle, clockwise: true)
 
        paht.addArc(withCenter: rightCenter, radius: radius, startAngle: -startAngle, endAngle: endAngle, clockwise: true)
        
        paht.lineWidth = CGFloat(0.0)
        paht.close()
        paht.stroke()
        
                
        maskLayer.path = paht.cgPath
        layer.mask = maskLayer
        
        context.addPath(paht.cgPath)
    }
}
