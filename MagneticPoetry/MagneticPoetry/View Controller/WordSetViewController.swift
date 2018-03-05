//
//  WordSetViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/17/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

class WordSetViewController: UITableViewController {
    @IBOutlet var WordBoxTableView: UITableView!
    var selectedWordSet: Int = -1
    var wordSets:Array<String> = []
    
    // MARK: - Override Functions -
    // ----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // removes footers from empty cells
        WordBoxTableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordSets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableWordSets", for: indexPath)
        
        cell.textLabel?.text = wordSets[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordSet = indexPath.row
    }
    
    // MARK: - Action Methods -
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
