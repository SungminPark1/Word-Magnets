//
//  PoemBrain.swift
//  MagneticPoetry
//
//  Created by Student on 3/4/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

protocol PoemBrainDelegate {
    func poemBrain(didChange poemBrain: PoemBrain, currentPoem: Array<UILabel>, poemTitle: String)
}

class PoemBrain {
    // create data model and delegate
    private var dataModel: PoemModel
    var delegate: PoemBrainDelegate!
    
    var currentPoem: Array<UILabel> {
        get {
            return dataModel.currentPoem
        }
        set {
            dataModel.currentPoem = newValue
            delegate?.poemBrain(didChange: self, currentPoem: newValue, poemTitle: self.poemTitle)
        }
    }
    var poemTitle: String {
        get {
            return dataModel.poemTitle
        }
        set {
            dataModel.poemTitle = newValue
            delegate?.poemBrain(didChange: self, currentPoem: self.currentPoem, poemTitle: newValue)
        }
    }
    
    init(dataModel: PoemModel = PoemModelUserDefaults()) {
        print(#function)
        self.dataModel = dataModel
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Objc functions -
    // -----------------------
    @objc func applicationWillEnterBackground(_ application: UIApplication) {
        dataModel.save()
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer, poemView: UIView) {
        movePoem(panGesture: panGesture, poemView: poemView)
    }
    
    // MARK - Helper Functions -
    // -------------------------
    func addToPoem(tapGesture: UITapGestureRecognizer, poemView: UIView) {
        let tappedLabel = tapGesture.view as! UILabel
        let newLabel = UILabel()
        
        newLabel.setText(text: tappedLabel.text!, fontSize: tappedLabel.font.pointSize)
        
        let x = CGFloat(arc4random_uniform(UInt32(poemView.frame.width - newLabel.frame.width - 30)) + 15)
        newLabel.checkMinSize(x: x, y: 20, minWidth: tappedLabel.frame.width, minHeight: tappedLabel.frame.height)
        
        newLabel.addShadow()
        
        // add gesture events to label
        newLabel.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
        newLabel.addGestureRecognizer(panGesture)
        
        currentPoem.append(newLabel)
        poemView.addSubview(newLabel)
        dataModel.save()
    }
    
    func clearPoem() {
        currentPoem.removeAll()
        dataModel.save()
    }
    
    func movePoem(panGesture: UIPanGestureRecognizer, poemView: UIView) {
        let label = panGesture.view as! UILabel
        
        poemView.bringSubview(toFront: label)
        
        let translation = panGesture.translation(in: poemView)
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
        panGesture.setTranslation(CGPoint.zero, in: poemView)
        
        dataModel.save()
    }
    
    func placeWordsInPoem(poemView: UIView) {
        for wordLabel in currentPoem {
            wordLabel.addShadow()
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            wordLabel.addGestureRecognizer(panGesture)
            
            poemView.addSubview(wordLabel)
        }
    }
    
    func changePoemTitle(textField: String)  {
        poemTitle = textField
        dataModel.save()
    }
    
}
