//
//  XYZColorImage.swift
//  XYZColor
//
//  Created by 张子豪 on 2019/9/29.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit

public extension UIImage {
    func colorMask(color:UIColor) -> UIImage {
        var result: UIImage?
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        if let c = UIGraphicsGetCurrentContext() {
            self.draw(in: rect)
            c.setFillColor(color.cgColor)
            c.setBlendMode(.sourceAtop)
            c.fill(rect)
            result = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return result ?? self
    }
}
