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
    var wordSelectorIndex: Int = 0
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
        
        placeWordsInWordBox(words: wordSelector.getWordSet(index: wordSelectorIndex))
    }
    
    // MARK - Helper Functions -
    // -------------------------
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
            
            // TO DO: Below if is used in another function create helper function
            // check if label is to small (min size 55x40)
            if (wordLabel.frame.width < 55) {
                wordLabel.frame = CGRect(x: x, y: y, width: 55, height: 40)
            } else {
                wordLabel.frame = CGRect(x: x, y: y, width: wordLabel.frame.width, height: 40)
            }
            
            xPlacement += xPadding + wordLabel.frame.width
            
            
            // add tap gesture to the labels in the word box
            wordLabel.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
            wordLabel.addGestureRecognizer(tapGesture)
            
            wordBoxLabelArray.append(wordLabel)
            wordBoxScrollView.addSubview(wordLabel)
            
        }
        
        wordBoxScrollView.contentSize.height = yPlacement + yPadding
    }
    
    
    // MARK: - Override Functions -
    // ----------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showWordSetSegue") {
            let wordSetVC = segue.destination.childViewControllers[0] as! WordSetViewController
            wordSetVC.wordSets = ["Word Set 1", "Word Set 2", "Word Set 3"]
            wordSetVC.title = "Choose a Word Set"
        }
    }
    
    // MARK - Objc functions -
    // -----------------------
    @objc func rotated() {
        isWordBoxCollapsed = true
        wordBoxScrollView.contentSize.width = UIScreen.main.bounds.width
        print(UIScreen.main.bounds.width)
        placeWordsInWordBox(words: wordSelector.getWordSet(index: wordSelectorIndex))
    }
    
    @objc func labelTapped(tapGesture: UITapGestureRecognizer) {
        let newLabel = UILabel()
        let tappedLabel = tapGesture.view as! UILabel
        
        newLabel.text = tappedLabel.text
        newLabel.textAlignment = .center
        newLabel.sizeToFit()
        newLabel.backgroundColor = UIColor.white
        
        // TO DO: Below if is used in another function create helper function
        // check if label is to small (min size 55x40)
        if (newLabel.frame.width < 55) {
            newLabel.frame = CGRect(x: 100, y: 100, width: 55, height: 40)
        } else {
            newLabel.frame = CGRect(x: 100, y: 100, width: newLabel.frame.width, height: 40)
        }
        
        // add gesture events to label
        newLabel.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(doRotationGesture))
        
        newLabel.addGestureRecognizer(panGesture)
        newLabel.addGestureRecognizer(rotationGesture)
        
        poemLabelArray.append(newLabel)
        view.addSubview(newLabel)
        isWordBoxCollapsed = true
    }
    
    @objc func doRotationGesture(rotationGesture: UIRotationGestureRecognizer) {
        let label = rotationGesture.view as! UILabel
        let rotation = rotationGesture.rotation
        label.transform = CGAffineTransform(rotationAngle: rotation)
        
        print(rotationGesture.rotation)
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        
        label.center = position
    }
    
    // MARK - IBActions -
    // ------------------
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
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        if (segue.identifier == "DoneTapped") {
            let wordSetVC = segue.source as! WordSetViewController
            
            if (wordSetVC.selectedWordSet == -1) {
                return
            }
            wordSelectorIndex = wordSetVC.selectedWordSet
            
            for label in wordBoxLabelArray {
                label.removeFromSuperview()
            }
            
            wordBoxLabelArray.removeAll()
            placeWordsInWordBox(words: wordSelector.getWordSet(index: wordSelectorIndex))
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
}

