//
//  PoemDefaults.swift
//  MagneticPoetry
//
//  Created by Student on 3/4/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

protocol PoemModel {
    var poemTitle: String {get set}
    var currentPoem: Array<UILabel> {get set}
    
    func save()
    func load()
}

// Objective-C naming convention for constants (start with k)
let kPoemTitle = "kPoemTitle"
let kCurrentPoem = "kCurrentPoem"


class PoemModelUserDefaults: PoemModel {
    let defaults: UserDefaults
    
    var currentPoem: Array<UILabel>
    var poemTitle: String
    
    // Initializer Dependency Injection with a default value
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        defaults = userDefaults
        currentPoem = Constants.PoemModel.defaultPoem
        poemTitle = Constants.PoemModel.defaultTitle
        
        load()
    }
    
    func save() {
        // encode the UIlabel array
        let encodedLabel = NSKeyedArchiver.archivedData(withRootObject: currentPoem)
        defaults.set(encodedLabel, forKey: kCurrentPoem)
        
        defaults.set(poemTitle, forKey: kPoemTitle)
    }
    
    func load() {
        let decoded  = UserDefaults.standard.object(forKey: kCurrentPoem) as! Data
        
        if let decodedPoem = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Array<UILabel>? {
            
            self.currentPoem = decodedPoem
        }
        else {
            print("loaded default poem")
            self.currentPoem = Constants.PoemModel.defaultPoem
        }
        
        if let poemTitle = defaults.value(forKey: kPoemTitle) as? String {
            self.poemTitle = poemTitle
        }
        else {
            self.poemTitle = Constants.PoemModel.defaultTitle
        }
        
        print("poem loaded")
    }
}
