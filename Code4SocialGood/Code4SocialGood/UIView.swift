//
//  UIView.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/24/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: - Border Methods
    
    @discardableResult func addBorders(edges: UIRectEdge, color: UIColor = UIColor.blue, thickness: CGFloat = 1.0) -> [UIView] {
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["top": top]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["left": left]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["right": right]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["bottom": bottom]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["bottom": bottom]))
            borders.append(bottom)
        }
        
        return borders
    }
    
    
    // MARK: - Color Methods
    
    func getColorAtPoint(_ point: CGPoint) -> UIColor {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.translateBy(x: -point.x, y: -point.y)
        
        self.layer.render(in: context)
        let color = UIColor(red:   CGFloat(pixel[0]) / 255.0,
                            green: CGFloat(pixel[1]) / 255.0,
                            blue:  CGFloat(pixel[2]) / 255.0,
                            alpha: CGFloat(pixel[3]) / 255.0)
        
        pixel.deallocate(capacity: 4)
        return color
    }

}
