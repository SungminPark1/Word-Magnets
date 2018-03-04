//
//  MenuPopupViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/22/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

class MenuPopupViewController: UIViewController, UINavigationControllerDelegate {
    // Variables
    var menuCells = ["Edit Title", "Edit Background", "Share", "Add Word", "Clear Poem"]
    var selectedCell: String = ""
    var selectedBackground: UIImage!
    var poemTitle: String = ""
    
    // Outlets
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTable.delegate = self
        menuTable.dataSource = self
        menuTable.tableFooterView = UIView(frame: .zero)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    func exitViewWithSegue() {
        performSegue(withIdentifier: "MenuTapped", sender: self)
    }
    
    @objc func viewTapped(tapGesture: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extensions -
// Table View DataSource
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

// Table View Delegate
extension MenuPopupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = menuCells[indexPath.row]
        
        if  menuCells[indexPath.row] == "Edit Title" {
            let alert = UIAlertController(title: "Enter poem's name", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "New Title"
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                let firstTextField = alert.textFields![0] as UITextField
                
                self.poemTitle = firstTextField.text!
                
                self.exitViewWithSegue()
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else if menuCells[indexPath.row] == "Edit Background" {
            let controller = UIImagePickerController()
            
            controller.delegate = self
            controller.sourceType = .photoLibrary
            
            present(controller, animated: true, completion: nil)
        } else if menuCells[indexPath.row] == "Share" {
            let image = self.presentingViewController?.view.takeSnapshot()
            let textToShare = "Share Text"
            let igmWebsite = NSURL(string: "http://igm.rit.edu/")
            let objectsToShare: [AnyObject] = [textToShare as AnyObject, igmWebsite!, image!]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.print]
            
            // specific for ipad
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
                let popoverMenuViewController = activityVC.popoverPresentationController
                popoverMenuViewController?.sourceView = self.view
                popoverMenuViewController?.permittedArrowDirections = .any
            }
            
            self.present(activityVC, animated: true, completion: nil)
        } else {
            exitViewWithSegue()
        }
    }
}

// Image Picker Controller Delegate
extension MenuPopupViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:  exitViewWithSegue)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedBackground = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        dismiss(animated: true, completion:  exitViewWithSegue)
    }
}
