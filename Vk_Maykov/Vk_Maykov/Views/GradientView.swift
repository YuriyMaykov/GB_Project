//
//  GradientView.swift
//  Vk_Maykov
//
//  Created by Юрий on 08/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    //MARK: - Свойства градиента
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable var midColor: UIColor = .gray {
        didSet {
            self.updateColors()
        }
    }

    @IBInspectable var mid2Color: UIColor = .gray {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable var startLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }
  
    @IBInspectable var midLocation: CGFloat = 0.3 {
        didSet {
            self.updateLocations()
        }
    }

    @IBInspectable var mid2Location: CGFloat = 0.6 {
        didSet {
            self.updateLocations()
        }
    }

    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
            self.updateLocations()
        }
    }
    
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            self.updateStartPoint()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.updateEndPoint()
        }
    }
    
    //MARK: - методы свойств
    private func updateLocations() {
        var locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
        
        if midLocation != 0 {
            locations.insert(midLocation as NSNumber, at: 1)
        }
        if mid2Location != 0 {
            locations.insert(mid2Location as NSNumber, at: 2)
        }

        self.gradientLayer.locations = locations
    }
    
    private func updateColors() {
        self.gradientLayer.colors = [
            self.startColor.cgColor,
            self.midColor.cgColor,
            self.mid2Color.cgColor,
            self.endColor.cgColor
        ]
    }
    
    private func updateStartPoint() {
        self.gradientLayer.startPoint = startPoint
    }
    
    private func updateEndPoint() {
        self.gradientLayer.endPoint = endPoint
    }
}
