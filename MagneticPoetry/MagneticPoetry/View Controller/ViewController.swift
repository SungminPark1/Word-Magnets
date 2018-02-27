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
    var labelArray: Array<UILabel> = []
    
    // navigation related var
    var navTitle: String? = "Poem Name"
    
    // Outlets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navBar.topItem?.title = navTitle
        navigationItem.title = "NEW TITLE"
        placeWords(words: wordSelector.getWordSet(index: 0))
    }
    
    func placeWords(words: Array<String>) {
        let screenWidth = UIScreen.main.bounds.width
        let xPadding: CGFloat = 15
        let yPadding: CGFloat = 50
        var xPlacement: CGFloat = 0
        var yPlacement: CGFloat = 80
        
        for word in words {
            let wordLabel = UILabel()
            wordLabel.textAlignment = .center
            wordLabel.text = word
            wordLabel.sizeToFit()
            wordLabel.backgroundColor = UIColor.cyan
            
            // check if placement will not go offscreen
            if (xPlacement + xPadding + wordLabel.frame.width >= screenWidth - xPadding) {
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
            
            // make label draggable
            wordLabel.isUserInteractionEnabled = true
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            wordLabel.addGestureRecognizer(panGesture)
            
            labelArray.append(wordLabel)
            view.addSubview(wordLabel)
        }
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
            
            for label in labelArray {
                label.removeFromSuperview()
            }
            
            labelArray.removeAll()
            placeWords(words: wordSelector.getWordSet(index: wordSetIndex))
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
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        
        label.center = position
    }
}

