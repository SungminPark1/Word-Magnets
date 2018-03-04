//
//  WordSet.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import Foundation

class WordSetSelector {
    var selectedSet: Int = 0
    
    let wordSets = ["Technology Words", "Geeky Words", "Basic Words", "Punctuation", "Suffixes", "Letters & Numbers", "Emojis"]
    
    let technologyWords = ["access", "AI", "Amazon", "analyze", "anonymous", "Apple", "application", "artificial", "back-up", "bandwidth", "bug", "bit", "bitcoin", "byte", "call", "card", "capacity", "cellphone", "circuit", "code", "corrupt", "computer", "CPU", "crash", "data", "database", "debug", "delete",  "develop", "developer", "digital", "download", "efficient", "electronic", "email", "Facebook", "file", "format", "function", "GB", "giga", "graphic", "Google", "GPU", "hacker", "hard-drive", "hardware", "HTML", "information", "innovate", "input", "intelligence", "intelligent", "interface", "internet", "iPad", "iPhone", "iPod", "instant", "jpeg", "keyboard", "kilo", "KB", "load", "log", "Mac", "MB", "mega", "memory", "Microsoft", "motherboard", "mouse", "monitor", "nerd", "network", "new", "offline", "online", "operating", "OS", "output", "parameter", "pasword", "PC", "pixel", "privacy", "processor", "program", "programm", "query", "RAM", "random", "re", "ROM", "save", "screen", "script", "search", "software", "spam", "speed", "static", "system", "TB", "tech", "technology", "tera", "trackball", "update", "user", "username", "upload", "value", "variable", "video", "virus", "web", "website", "wireless", "Windows", "YouTube"]
    
    let geekyWords = ["geek", "Elon Musk", "Space-X", "cryptocurrency", "game", "video", "lag", "MOBA", "e-sports", "FPS", "RPG", "MMO", "online", "ping", "platformer", "puzzle", "beat-em-up", "run-and-gun", "shmup", "role-play", "LARP", "magic", "sports", "alchemy", "wizard", "magician", "witch", "alchemist", "theif", "warrior", "knight", "paladin", "sorceror", "archer", "tank", "OP", "loot", "demon", "angel", "orc", "troll", "dwarf", "elf", "giant", "human", "Cthulu", "death", "dead", "die", "live", "life", "HP"].sorted{ $0.lowercased() < $1.lowercased() }
    
    let basicWords = ["a", "about", "above", "after", "an", "am", "are", "around", "at", "be", "because", "been", "before", "behind", "below", "beside", "beyond", "but", "by", "can", "could", "do", "does", "did", "during", "for", "from", "had", "have", "he", "her", "him", "I", "in", "inside", "into", "is", "it", "like", "may", "me", "might", "must", "near", "not", "of", "off", "on", "outside", "over", "shall", "she", "should", "since", "the", "their", "them", "they", "through", "to", "us", "was", "we", "were", "will", "with", "without", "won't", "would",  "you"]
    
    let punctuation = [",", ";", ".", "?", "!", "@", "#", "$", "%", "&", "*", "(", ")", "-", "_", "+", "=", "{", "}", "~", "/", "\\", "[", "]"]
    
    let suffixes = ["'re", "able", "al", "ance", "ant", "ate", "ed", "ence", "en", "ent", "er", "ful", "ible", "ic", "ify", "ing", "ion", "ise", "ity", "ive", "ize", "less", "ly", "ment", "n't", "ness", "or", "ous", "s", "ship", "ves", "y", "ly"]
    
    let alphaNumerics = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    let emojis = ["😀", "😃", "😄", "😁", "😆", "😅", "😂" ,"🤣", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "😘", "😗", "😙", "😚", "😋", "😜", "😝", "😛", "🤑", "🤗", "🤓", "😎", "🤡", "🤠", "😏", "😒", "😞", "😔", "😟", "😕", "🙁", "☹️", "😣", "😖", "😫", "😩", "😤", "😠", "😡", "😶", "😐", "😑", "😯", "😦", "😧", "😮", "😲", "😵", "😳", "😱", "😨", "😰", "😢", "😥", "🤤", "😭", "😓", "😪", "😴", "🙄", "🤔", "🤥", "😬", "🤐", "🤢", "🤧", "😷", "🤒", "🤕", "💩", "👐", "🙌", "👏", "🙏", "🤝", "👍", "👎", "👊", "✊", "🤛", "🤜", "🤞", "✌️", "🤘", "👌", "👈", "👉", "👆", "👇", "☝️", "✋", "🤚", "🖐", "🖖", "👋", "🤙", "💪", "🖕", "🍆", "💯"]
    
    
    init() {
        selectedSet = 0
    }
    
    func getWordSet() -> Array<String> {

        switch selectedSet {
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
}
