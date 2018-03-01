//
//  WordSet.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import Foundation

class WordSetSelector {
    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    
    let words_2 = ["word", "set", "two"]
    
    let words_3 = ["word", "set", "three"]
    
    let punctuation = [",", ";", ".", "?", "!", "@", "#", "$", "%", "&", "*", "(", ")", "-", "_", "+", "=", "{", "}", "~", "/", "\\", "[", "]"]
    
    let nounSuffixes = ["ance", "ence", "er", "ion", "ity", "er", "ion", "ity", "ment", "ness", "or", "ship"]
    
    let verbSuffixes = ["ate", "en", "ed", "ify", "ing", "ise", "ize", "ly"]
    
    let adjectiveSuffixes = ["able", "al", "ant", "ant", "ed", "ent", "ful", "ible", "ic", "ing", "ive", "less", "ly", "ous", "y"]
    
    let emojis = ["😀", "😃", "😄", "😁", "😆", "😅", "😂" ,"🤣", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "😘", "😗", "😙", "😚", "😋", "😜", "😝", "😛", "🤑", "🤗", "🤓", "😎", "🤡", "🤠", "😏", "😒", "😞", "😔", "😟", "😕", "🙁", "☹️", "😣", "😖", "😫", "😩", "😤", "😠", "😡", "😶", "😐", "😑", "😯", "😦", "😧", "😮", "😲", "😵", "😳", "😱", "😨", "😰", "😢", "😥", "🤤", "😭", "😓", "😪", "😴", "🙄", "🤔", "🤥", "😬", "🤐", "🤢", "🤧", "😷", "🤒", "🤕", "💩", "👐", "🙌", "👏", "🙏", "🤝", "👍", "👎", "👊", "✊", "🤛", "🤜", "🤞", "✌️", "🤘", "👌", "👈", "👉", "👆", "👇", "☝️", "✋", "🤚", "🖐", "🖖", "👋", "🤙", "💪", "🖕", "🍆", "💯"]
    
    
    init() {
        
    }
    
    func getWordSet(index: Int) -> Array<String> {

        switch index {
        case 0:
            return words
        case 1:
            return words_2
        case 2:
            return words_3
        case 3:
            return punctuation
        case 4:
            return nounSuffixes
        case 5:
            return verbSuffixes
        case 6:
            return adjectiveSuffixes
        case 7:
            return emojis
        default:
            return []
        }
    }
}
