//
//  UIViewExtension.swift
//  MagneticPoetry
//
//  Created by Balor on 2/27/18.
//  Copyright © 2018 Sungmin Park. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func takeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetPDFContextBounds()
        
        return image
    }
}
