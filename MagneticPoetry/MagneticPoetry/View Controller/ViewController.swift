//
//  ViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var WordSetToolBar: UIToolbar!
    @IBOutlet weak var WordBoxScrollView: UIScrollView!
    
    var isWordBoxCollapsed = true
    
    
    var wordSelector = WordSetSelector()
    var wordSelectIndex: Int? = 0
    var wordBoxLabelArray: Array<UILabel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // detect if the user has rotated the screen
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        isWordBoxCollapsed = true

        WordBoxScrollView.contentSize.width = UIScreen.main.bounds.width
        print(UIScreen.main.bounds.width)

        
        placeWords(words: wordSelector.getWordSet(index: wordSelectIndex))
        
    }
    
    func placeWords(words: Array<String>) {
        print(#function + " called")
        let wordBoxWidth = WordBoxScrollView.contentSize.width
        let xPadding: CGFloat = 15
        let yPadding: CGFloat = 50
        var xPlacement: CGFloat = 0
        var yPlacement: CGFloat = 20
        
        for word in words {
            let wordLabel = UILabel()
            wordLabel.textAlignment = .center
            wordLabel.text = word
            wordLabel.sizeToFit()
            wordLabel.backgroundColor = UIColor.white
            
            // check if placement will not go offscreen
            if (xPlacement + xPadding + wordLabel.frame.width >= wordBoxWidth - xPadding) {
                xPlacement = 0
                yPlacement += yPadding
            }
            
            // set x and y
            let x: CGFloat = xPlacement + xPadding
            let y: CGFloat = yPlacement
            
            // check if label is to small (min size 40x40)
            if (wordLabel.frame.width < 40) {
                wordLabel.frame = CGRect(x: x, y: y, width: 40, height: 40)
            } else {
                wordLabel.frame = CGRect(x: x, y: y, width: wordLabel.frame.width, height: 40)
            }
            
            xPlacement += xPadding + wordLabel.frame.width
            
            
            wordBoxLabelArray.append(wordLabel)
            WordBoxScrollView.addSubview(wordLabel)
            
        }
        
        WordBoxScrollView.contentSize.height = yPlacement + yPadding
    }
    
    @objc func rotated() {
        
        isWordBoxCollapsed = true
        WordBoxScrollView.contentSize.width = UIScreen.main.bounds.width
        print(UIScreen.main.bounds.width)
        placeWords(words: wordSelector.getWordSet(index: wordSelectIndex))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showWordSetSegue") {
            let wordSetVC = segue.destination.childViewControllers[0] as! WordSetViewController
            wordSetVC.wordSets = ["Word Set 1", "Word Set 2", "Word Set 3"]
            wordSetVC.title = "Choose a Word Set"
        }
    }
    
    // ACTIONS
    //-------------------------------
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        if (segue.identifier == "DoneTapped") {
            let wordSetVC = segue.source as! WordSetViewController
            
            if (wordSetVC.selectedWordSet == nil) {
                print(#function + "exited with nil")
                return
            }
            wordSelectIndex = wordSetVC.selectedWordSet
            
            for label in wordBoxLabelArray {
                label.removeFromSuperview()
            }
            
            wordBoxLabelArray.removeAll()
            isWordBoxCollapsed = true
            placeWords(words: wordSelector.getWordSet(index: wordSelectIndex))
        }
    }
    
    @IBAction func ShowWordBox(_ sender: Any) {
        
        let wordBoxCollapseDistance: CGFloat = WordBoxScrollView.frame.height
        
        // scroll wordbox and wordSetToolbar up if collapsed
        if(isWordBoxCollapsed) {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.WordSetToolBar.frame.origin.y -= (wordBoxCollapseDistance)
                self.WordBoxScrollView.frame.origin.y -= (wordBoxCollapseDistance)
                
            }, completion: { (value: Bool) in
                self.isWordBoxCollapsed = false
                
                
            })
        }
        // scroll wordbox and wordSetToolbar down if not collapsed
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.WordSetToolBar.frame.origin.y += (wordBoxCollapseDistance)
                self.WordBoxScrollView.frame.origin.y += (wordBoxCollapseDistance)
                
            }, completion: { (value: Bool) in
                self.isWordBoxCollapsed = true
                
            })
        }
        
    }
    

    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        
        label.center = position
    }
    
    
}

