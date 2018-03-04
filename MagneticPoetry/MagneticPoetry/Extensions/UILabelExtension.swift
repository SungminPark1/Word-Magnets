//
//  UILabelExtension.swift
//  MagneticPoetry
//
//  Created by Balor on 3/4/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    // check size and set origin point
    func checkMinSize(x: CGFloat, y: CGFloat, minWidth: CGFloat, minHeight: CGFloat) {
        if (self.frame.width < minWidth) {
            self.frame = CGRect(x: x, y: y, width: minWidth, height: minHeight)
        } else {
            self.frame = CGRect(x: x, y: y, width: self.frame.width, height: minHeight)
        }
    }
    
    // check size
    func checkMinSize(minWidth: CGFloat, minHeight: CGFloat) {
        if (self.frame.width < minWidth) {
            self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: minWidth, height: minHeight)
        } else {
            self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.bounds.width, height: minHeight)
        }
    }
}
