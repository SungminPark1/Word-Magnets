//
//  WordSet.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

protocol WordSetSelectorDelegate {
    func wordSetSelector(didChange wordSetSelector: WordSetSelector, selectedSetIndex: Int, technologyWords: Array<String>, geekyWords: Array<String>, basicWords: Array<String>, punctuation: Array<String>, suffixes: Array<String>, alphaNumerics: Array<String>, emojis: Array<String>)
}

class WordSetSelector {
    // IVARS
    // -----------------
    private var dataModel: WordSetSelectorModel
    var delegate: WordSetSelectorDelegate?
    
    var selectedSetIndex: Int {
        get {
            return dataModel.wordSetIndex
        }
        set {
            dataModel.wordSetIndex = newValue
            delegate?.wordSetSelector(didChange: self, selectedSetIndex: newValue, technologyWords: self.technologyWords, geekyWords: self.geekyWords, basicWords: self.basicWords, punctuation: self.punctuation, suffixes: self.suffixes, alphaNumerics: self.alphaNumerics, emojis: self.emojis)
        }
    }
    
    var wordSets: Array<String> {
        get {
            return dataModel.wordSets
        }
    }
    
    
    var technologyWords: Array<String> {
        get {
            return dataModel.technologyWords
        }
        set {
            dataModel.technologyWords = newValue
            delegate?.wordSetSelector(didChange: self, selectedSetIndex: self.selectedSetIndex, technologyWords: newValue, geekyWords: self.geekyWords, basicWords: self.basicWords, punctuation: self.punctuation, suffixes: self.suffixes, alphaNumerics: self.alphaNumerics, emojis: self.emojis)
        }
    }
    
    var geekyWords: Array<String> {
        get {
            return dataModel.geekyWords
        }
        set {
            dataModel.geekyWords = newValue
            delegate?.wordSetSelector(didChange: self, selectedSetIndex: self.selectedSetIndex, technologyWords: self.technologyWords, geekyWords: newValue, basicWords: self.basicWords, punctuation: self.punctuation, suffixes: self.suffixes, alphaNumerics: self.alphaNumerics, emojis: self.emojis)
        }
    }
    
    var basicWords: Array<String> {
        get {
            return dataModel.basicWords
        }
        set {
            dataModel.basicWords = newValue
            delegate?.wordSetSelector(didChange: self, selectedSetIndex: self.selectedSetIndex, technologyWords: self.technologyWords, geekyWords: self.geekyWords, basicWords: newValue, punctuation: self.punctuation, suffixes: self.suffixes, alphaNumerics: self.alphaNumerics, emojis: self.emojis)
        }
    }
    
    var punctuation: Array<String> {
        get {
            return dataModel.punctuation
        }
        set {
            dataModel.punctuation = newValue
            delegate?.wordSetSelector(didChange: self, selectedSetIndex: self.selectedSetIndex, technologyWords: self.technologyWords, geekyWords: self.geekyWords, basicWords: self.basicWords, punctuation: newValue, suffixes: self.suffixes, alphaNumerics: self.alphaNumerics, emojis: self.emojis)
        }
    }
    
    var suffixes: Array<String> {
        get {
            return dataModel.suffixes
        }
        set {
            dataModel.suffixes = newValue
            delegate?.wordSetSelector(didChange: self, selectedSetIndex: self.selectedSetIndex, technologyWords: self.technologyWords, geekyWords: self.geekyWords, basicWords: self.basicWords, punctuation: self.punctuation, suffixes: newValue, alphaNumerics: self.alphaNumerics, emojis: self.emojis)
        }
    }
    
    var alphaNumerics: Array<String> {
        get {
            return dataModel.alphaNumerics
        }
        set {
            dataModel.alphaNumerics = newValue
            delegate?.wordSetSelector(didChange: self, selectedSetIndex: self.selectedSetIndex, technologyWords: self.technologyWords, geekyWords: self.geekyWords, basicWords: self.basicWords, punctuation: self.punctuation, suffixes: self.suffixes, alphaNumerics: newValue, emojis: self.emojis)
        }
    }
    
    var emojis: Array<String> {
        get {
            return dataModel.emojis
        }
        set {
            dataModel.emojis = newValue
            delegate?.wordSetSelector(didChange: self, selectedSetIndex: self.selectedSetIndex, technologyWords: self.technologyWords, geekyWords: self.geekyWords, basicWords: self.basicWords, punctuation: self.punctuation, suffixes: self.suffixes, alphaNumerics: self.alphaNumerics, emojis: newValue)
        }
    }
    
    
    init(dataModel: WordSetSelectorModel = WordSetSelectorModelUserDefaults()) {
        self.dataModel = dataModel
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func applicationWillEnterBackground(_ application: UIApplication) {
        print("about to save word set")
        dataModel.save()
    }
    
    func getWordSet() -> Array<String> {

        dataModel.save()
        switch selectedSetIndex {
        case 0:
            return technologyWords
        case 1:
            return geekyWords
        case 2:
            return basicWords
        case 3:
            return punctuation
        case 4:
            return suffixes
        case 5:
            return alphaNumerics
        case 6:
            return emojis
        default:
            return []
        }
    }
    
    func addWordToCurrentSet(word: String) {
        switch selectedSetIndex {
        case 0:
            technologyWords.append(word)
        case 1:
            geekyWords.append(word)
        case 2:
            basicWords.append(word)
        case 3:
            punctuation.append(word)
        case 4:
            suffixes.append(word)
        case 5:
            alphaNumerics.append(word)
        case 6:
            emojis.append(word)
        default:
            technologyWords.append(word)
        }
    }
}
