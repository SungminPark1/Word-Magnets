//
//  WordSet.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park. All rights reserved.
//

import Foundation

class WordSetSelector {
    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    
    let words_2 = ["word", "set", "two"]
    
    let words_3 = ["word", "set", "three"]
    
    init() {
        
    }
    
    func getWordSet(index: Int?) -> Array<String> {
//        print(#function + " index: \(index)")
        switch index {
        case 0?:
            return words
        case 1?:
            return words_2
        case 2?:
            return words_3
        default:
            return []
        }
    }
}
