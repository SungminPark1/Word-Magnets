//
//  UILabelExtension.swift
//  MagneticPoetry
//
//  Created by Balor on 3/4/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

extension UILabel {
    func setText(text: String, fontSize: CGFloat) {
        self.textAlignment = .center
        self.text = text
        self.font = self.font.withSize(fontSize)
        self.sizeToFit()
        self.backgroundColor = UIColor.white
    }
    
    // check size is alteast min size and set origin point
    func checkMinSize(x: CGFloat, y: CGFloat, minWidth: CGFloat, minHeight: CGFloat) {
        if (self.frame.width < minWidth) {
            self.frame = CGRect(x: x, y: y, width: minWidth, height: minHeight)
        } else {
            self.frame = CGRect(x: x, y: y, width: self.frame.width, height: minHeight)
        }
    }
    
    // check if label is alteast min size
    func checkMinSize(minWidth: CGFloat, minHeight: CGFloat) {
        if (self.frame.width < minWidth) {
            self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: minWidth, height: minHeight)
        } else {
            self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.bounds.width, height: minHeight)
        }
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowOffset = CGSize(width: 1, height: 3)
        self.layer.masksToBounds = false
    }
}
