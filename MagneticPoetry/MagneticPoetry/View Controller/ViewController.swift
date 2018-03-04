//
//  ViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // poem related var
    var poemLabelArray: Array<UILabel> = []
    var poemTitle: String = "Poem Name"
    
    // wordSelector related var
    var wordSelector = WordSetSelector()
    var wordBoxLabelArray: Array<UILabel> = []
    var isWordBoxCollapsed: Bool = true
    
    // Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var poemView: UIView!
    @IBOutlet weak var wordBoxScrollView: UIScrollView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var toolBarBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = poemTitle
        
        isWordBoxCollapsed = true
        wordBoxScrollView.contentSize.width = UIScreen.main.bounds.width
        
        placeWordsInWordBox(words: wordSelector.getWordSet())
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
            
            wordLabel.checkSize(x: x, y: y, minWidth: 55, minHeight: 40)
            
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
    
    // clears all labels in array
    func clearLableArray(labelArray: Array<UILabel>) {
        for label in labelArray {
            label.removeFromSuperview()
        }
    }
    
    // MARK: - Override Functions -
    // ----------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showWordSetSegue") {
            let wordSetVC = segue.destination.childViewControllers[0] as! WordSetViewController
            wordSetVC.wordSets = wordSelector.wordSets
        } else if (segue.identifier == "popupMenuSegue") {
            // close the wordbox when opening the menu
            if !isWordBoxCollapsed {
                UIView.animate(withDuration: 0.5, animations: {
                    self.toolBarBottomConstraint.constant = 0
                    self.view.layoutIfNeeded()
                    
                }, completion: { (value: Bool) in
                    self.isWordBoxCollapsed = true
                    
                })
            }
        }
    }
    
    // MARK: - Objc functions -
    // -----------------------
    @objc func labelTapped(tapGesture: UITapGestureRecognizer) {
        let newLabel = UILabel()
        let tappedLabel = tapGesture.view as! UILabel
        
        newLabel.text = tappedLabel.text
        newLabel.textAlignment = .center
        newLabel.sizeToFit()
        newLabel.backgroundColor = UIColor.white

        newLabel.checkSize(x: 100, y: 100, minWidth: 55, minHeight: 40)
        
        // box shaddow
        newLabel.layer.shadowColor = UIColor.black.cgColor
        newLabel.layer.shadowOpacity = 0.75
        newLabel.layer.shadowOffset = CGSize(width: 1, height: 3)
        newLabel.layer.masksToBounds = false
        
        // add gesture events to label
        newLabel.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(doRotationGesture))
        
        newLabel.addGestureRecognizer(panGesture)
        newLabel.addGestureRecognizer(rotationGesture)
        
        poemLabelArray.append(newLabel)
        poemView.addSubview(newLabel)
    }
    
    @objc func doRotationGesture(rotationGesture: UIRotationGestureRecognizer) {
        let label = rotationGesture.view as! UILabel
        let rotation = rotationGesture.rotation
        label.transform = CGAffineTransform(rotationAngle: rotation)
        
        print(rotationGesture.rotation)
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: poemView)
        
        label.center = position
    }
    
    // MARK: - IBActions -
    // ------------------
    @IBAction func ShowWordBox(_ sender: Any) {
        let wordBoxCollapseDistance: CGFloat = wordBoxScrollView.frame.height
        
        // scroll wordbox and wordSetToolbar up and down
        if isWordBoxCollapsed {
            UIView.animate(withDuration: 0.5, animations: {
                self.toolBarBottomConstraint.constant = wordBoxCollapseDistance
                self.view.layoutIfNeeded()
            }, completion: { (value: Bool) in
                self.isWordBoxCollapsed = false
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.toolBarBottomConstraint.constant = 0
                self.view.layoutIfNeeded()
                
            }, completion: { (value: Bool) in
                self.isWordBoxCollapsed = true
                
            })
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneTapped" {
            let wordSetVC = segue.source as! WordSetViewController
            
            if wordSetVC.selectedWordSet == -1 {
                return
            }
            
            clearLableArray(labelArray: wordBoxLabelArray)
            wordBoxLabelArray.removeAll()
            
            wordSelector.selectedSet = wordSetVC.selectedWordSet
            placeWordsInWordBox(words: wordSelector.getWordSet())
        } else if segue.identifier == "MenuTapped" {
            let menuPopupVC = segue.source as! MenuPopupViewController
            print("MenuPopup: \(menuPopupVC.selectedCell)")
            
            if menuPopupVC.selectedCell == "Edit Title" {
                // edit the title of the poem if poemTitle is not empty
                if menuPopupVC.poemTitle == "" {
                    return
                }
            
                self.poemTitle = menuPopupVC.poemTitle
                self.navigationItem.title = poemTitle
            } else if menuPopupVC.selectedCell == "Edit Background" {
                // set background if selectedBackground is not nil
                if (menuPopupVC.selectedBackground == nil) {
                    return
                }
                
                backgroundImage.image = menuPopupVC.selectedBackground
            } else if menuPopupVC.selectedCell == "Clear Poem" {
                clearLableArray(labelArray: poemLabelArray)
                poemLabelArray.removeAll()
            }
        }
    }
}

