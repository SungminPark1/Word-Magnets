//
//  ViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var wordSelector = WordSetSelector()
    var wordSelectorIndex: Int? = 0
    var wordBoxLabelArray: Array<UILabel> = []
    var poemLabelArray: Array<UILabel> = []
    
    // navigation related var
    var navTitle: String? = "Poem Name"
    
    // toolbar related var
    var isWordBoxCollapsed: Bool = true
    
    // Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var wordBoxScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navBar.topItem?.title = navTitle
        navigationItem.title = "New Poem"
        
        // detect if the user has rotated the screen
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        isWordBoxCollapsed = true
        
        wordBoxScrollView.contentSize.width = UIScreen.main.bounds.width
        
        placeWordsInWordBox(words: wordSelector.getWordSet(index: 0))
    }
    
    func placeWordsInWordBox(words: Array<String>) {
        let wordBoxWidth = wordBoxScrollView.contentSize.width
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
            
            // check if label is to small (min size 55x40)
            if (wordLabel.frame.width < 55) {
                wordLabel.frame = CGRect(x: x, y: y, width: 55, height: 40)
            } else {
                wordLabel.frame = CGRect(x: x, y: y, width: wordLabel.frame.width, height: 40)
            }
            
            xPlacement += xPadding + wordLabel.frame.width
            
//            // make label draggable
//            wordLabel.isUserInteractionEnabled = true
//
//            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
//            wordLabel.addGestureRecognizer(panGesture)
            
            wordBoxLabelArray.append(wordLabel)
            wordBoxScrollView.addSubview(wordLabel)
            
        }
        
        wordBoxScrollView.contentSize.height = yPlacement + yPadding
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showWordSetSegue") {
            let wordSetVC = segue.destination.childViewControllers[0] as! WordSetViewController
            wordSetVC.wordSets = ["Word Set 1", "Word Set 2", "Word Set 3"]
            wordSetVC.title = "Choose a Word Set"
        }
    }
    
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        if (segue.identifier == "DoneTapped") {
            let wordSetVC = segue.source as! WordSetViewController
            
            if (wordSetVC.selectedWordSet == nil) {
                return
            }
            let wordSetIndex = wordSetVC.selectedWordSet
            
            for label in wordBoxLabelArray {
                label.removeFromSuperview()
            }
            
            wordBoxLabelArray.removeAll()
            placeWordsInWordBox(words: wordSelector.getWordSet(index: wordSetIndex!))
        } else if (segue.identifier == "MenuTapped") {
            let menuPopupVC = segue.source as! MenuPopupViewController
            print("MenuTapped")
            
            if (menuPopupVC.selectedCell == "Edit Background") {
                if (menuPopupVC.selectedBackground == nil) {
                    return
                }
                backgroundImage.image = menuPopupVC.selectedBackground
                self.view.sendSubview(toBack: backgroundImage)
                print("Background")
            } else if (menuPopupVC.selectedCell == "Clear") {
                print("clear board")
            }
        }
    }
    
    @objc func rotated() {
        isWordBoxCollapsed = true
        wordBoxScrollView.contentSize.width = UIScreen.main.bounds.width
        print(UIScreen.main.bounds.width)
        placeWordsInWordBox(words: wordSelector.getWordSet(index: wordSelectorIndex!))
    }
    
    @IBAction func ShowWordBox(_ sender: Any) {
        
        let wordBoxCollapseDistance: CGFloat = wordBoxScrollView.frame.height
        
        // scroll wordbox and wordSetToolbar up if collapsed
        if(isWordBoxCollapsed) {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.toolBar.frame.origin.y -= (wordBoxCollapseDistance)
                self.wordBoxScrollView.frame.origin.y -= (wordBoxCollapseDistance)
                
            }, completion: { (value: Bool) in
                self.isWordBoxCollapsed = false
                
                
            })
        }
            // scroll wordbox and wordSetToolbar down if not collapsed
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.toolBar.frame.origin.y += (wordBoxCollapseDistance)
                self.wordBoxScrollView.frame.origin.y += (wordBoxCollapseDistance)
                
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

