//
//  WordSetViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park. All rights reserved.
//

import UIKit

class WordSetViewController: UITableViewController {
    var wordSets = ["set1", "set2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(#function + " called")
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function + " called with \(wordSets.count) rows")
        
        return wordSets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function + " called with indexPath \(indexPath) and color \(wordSets[indexPath.row])")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableWordSets", for: indexPath)
        
        // display the color name
        cell.textLabel?.text = wordSets[indexPath.row]
        
        return cell
    }
    
    
    // MARK: - Action Methods -
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
