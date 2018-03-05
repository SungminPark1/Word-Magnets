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
    var poemBrain = PoemBrain()
    
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
        
        navigationItem.title = poemBrain.poemTitle
        
        poemBrain.placeWordsInPoem(poemView: self.poemView)
        
        isWordBoxCollapsed = true
        
        placeWordsInWordBox(words: wordSelector.getWordSet())
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK - Helper Functions -
    // -------------------------
    func placeWordsInWordBox(words: Array<String>) {
        let wordBoxWidth = wordBoxScrollView.bounds.width
        let minLabelWidth: CGFloat = 55
        let minLabelHeight: CGFloat = 40
        let xPadding: CGFloat = 15
        let yPadding: CGFloat = minLabelHeight + 15
        
        var xPlacement: CGFloat = 0
        var yPlacement: CGFloat = 15
        
        for word in words {
            let wordLabel = UILabel()
            
            wordLabel.textAlignment = .center
            wordLabel.text = word
            wordLabel.sizeToFit()
            wordLabel.backgroundColor = UIColor.white
            
            wordLabel.checkMinSize(minWidth: minLabelWidth, minHeight: minLabelHeight)
            
            // check if placement will not go offscreen
            if (xPlacement + xPadding + wordLabel.frame.width >= wordBoxWidth - xPadding) {
                xPlacement = 0
                yPlacement += yPadding
            }
            
            // set x and y location
            wordLabel.frame.origin.x = xPlacement + xPadding
            wordLabel.frame.origin.y = yPlacement
            
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
    
    // remove all labels in view
    func removeLabelFromView(labelArray: Array<UILabel>) {
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
        
        poemBrain.addToPoem(newLabel: newLabel, tapGesture: tapGesture, poemView: poemView)
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
            
            removeLabelFromView(labelArray: wordBoxLabelArray)
            wordBoxLabelArray.removeAll()
            
            wordSelector.selectedSetIndex = wordSetVC.selectedWordSet
            placeWordsInWordBox(words: wordSelector.getWordSet())
        } else if segue.identifier == "MenuTapped" {
            let menuPopupVC = segue.source as! MenuPopupViewController
            
            if menuPopupVC.selectedCell == "Edit Title" {
                // edit the title of the poem if poemTitle is not empty
                if menuPopupVC.alertTextField == "" {
                    return
                }
            
                poemBrain.changePoemTitle(textField: menuPopupVC.alertTextField)
                self.navigationItem.title = poemBrain.poemTitle
            } else if menuPopupVC.selectedCell == "Edit Background" {
                // set background if selectedBackground is not nil
                if (menuPopupVC.selectedBackground == nil) {
                    return
                }
                
                backgroundImage.image = menuPopupVC.selectedBackground
            } else if menuPopupVC.selectedCell == "Add Word" {
                if menuPopupVC.alertTextField == "" {
                    return
                }
                
                wordSelector.addWordToCurrentSet(word: menuPopupVC.alertTextField)
                placeWordsInWordBox(words: wordSelector.getWordSet())
            } else if menuPopupVC.selectedCell == "Clear Poem" {
                removeLabelFromView(labelArray: poemBrain.currentPoem)
                poemBrain.clearPoem()
            }
        }
    }
}


