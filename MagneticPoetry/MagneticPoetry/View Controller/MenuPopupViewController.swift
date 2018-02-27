//
//  MenuPopupViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/22/18.
//  Copyright © 2018 Sungmin Park. All rights reserved.
//

import UIKit

//protocol MenuPopupControllerDelegate {
//    func menuPopupController(didEditName: MenuPopupViewController)
//    func menuPopupController(didChangeBackground: MenuPopupViewController)
//    func menuPopupController(didSelect)
//}

class MenuPopupViewController: UIViewController, UINavigationControllerDelegate {
    // Variables
    var menuCells = ["Edit Name", "Edit Background", "Share", "Clear"]
    var selectedCell: String = ""
    var selectedBackground: UIImage!
    
    // Outlets
    @IBOutlet weak var menuTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTable.delegate = self
        menuTable.dataSource = self
        menuTable.tableFooterView = UIView(frame: .zero)
    }
    
    func exitViewWithSegue() {
        performSegue(withIdentifier: "MenuTapped", sender: self)
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
        
        return cell
    }
}

// MARK: - Table View Delegate
extension MenuPopupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = menuCells[indexPath.row]
        
        if (menuCells[indexPath.row] == "Edit Background") {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = .photoLibrary
            present(controller, animated: true, completion: nil)
        } else {
            exitViewWithSegue()
        }
    }
}

// MARK: - Image Picker Controller Delegate
extension MenuPopupViewController: UIImagePickerControllerDelegate {
    // TO DO: find a way to move this to another file?
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        exitViewWithSegue()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedBackground = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        exitViewWithSegue()
    }
}
