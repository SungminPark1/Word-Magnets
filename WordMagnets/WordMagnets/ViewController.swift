//
//  ViewController.swift
//  WordMagnets
//
//  Created by Sungmin Park and Ian Oliver on 2/11/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeWords()
    }
    
    func placeWords() {
        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
        let xPadding: CGFloat = 15;
        let yPadding: CGFloat = 50;
        var xPlacement: CGFloat = 0;
        var yPlacement: CGFloat = 30;
        
        for word in words {
            let l = UILabel()
            l.textAlignment = .center
            l.text = word
            l.sizeToFit()
            l.backgroundColor = UIColor.cyan // used to show label size
            
            // check if placement will not go offscreen
            if (xPlacement + xPadding + l.frame.width >= screenWidth - xPadding) {
                // reset xPlacement and update yPlacement
                xPlacement = 0
                yPlacement += yPadding
            }
            
            // set x and y
            let x: CGFloat = xPlacement + xPadding
            let y: CGFloat = yPlacement
            
            // check if label is to small (min size 40x40)
            if (l.frame.width < 40) {
                l.frame = CGRect(x: x, y: y, width: 40, height: 40)
            } else {
                l.frame = CGRect(x: x, y: y, width: l.frame.width , height: 40)
            }
            
            // update xPlacement
            xPlacement += xPadding + l.frame.width
            
            // make label draggable
            l.isUserInteractionEnabled = true
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            l.addGestureRecognizer(panGesture)
            
            // add word label to view
            view.addSubview(l)
        }
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        
        label.center = position
    }
}

