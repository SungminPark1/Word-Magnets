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
    func checkSize(x: CGFloat, y: CGFloat, minWidth: CGFloat, minHeight: CGFloat) {
        if (self.frame.width < minWidth) {
            self.frame = CGRect(x: x, y: y, width: minWidth, height: minHeight)
        } else {
            self.frame = CGRect(x: x, y: y, width: self.frame.width, height: minHeight)
        }
    }
}
