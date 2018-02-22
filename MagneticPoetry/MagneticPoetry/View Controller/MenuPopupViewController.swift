//
//  MenuPopupViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/22/18.
//  Copyright © 2018 Sungmin Park. All rights reserved.
//

import UIKit

class MenuPopupViewController: UIViewController {
    // Variables
    var menuCells = ["Edit Name", "Background", "Share", "Clear"]
    var selectedCell: String = ""
    
    // Outlets
    @IBOutlet weak var menuTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        menuTable.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
        menuTable.delegate = self
        menuTable.dataSource = self
    }
    
    // MARK: - Action Methods -
    @IBAction func exitView(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table View DataSource
extension MenuPopupViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        cell.textLabel?.text = menuCells[indexPath.row]
//        cell.backgroundColor = .gray
        
        return cell
    }
}

// MARK: - Table View Delegate
extension MenuPopupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = menuCells[indexPath.row]
        performSegue(withIdentifier: "MenuTapped", sender: self)
        exitView(sender: self)
    }
}

