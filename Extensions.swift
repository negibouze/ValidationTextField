//
//  UIKItExtensions.swift
//  ValidationTextField
//
//  Created by Yoshiaki Itakura on 2015/11/23.
//  Copyright © 2015年 personal. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgb(red: Int, green: Int, blue: Int) -> UIColor {
        return rgba(red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    class func defaultBorderColor() -> UIColor {
        return rgba(204, green: 204, blue: 204, alpha: 0.5)
    }
}
