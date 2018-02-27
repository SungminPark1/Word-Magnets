//
//  MenuPopupViewController.swift
//  MagneticPoetry
//
//  Created by Balor on 2/22/18.
//  Copyright © 2018 Sungmin Park and Ian Oliver. All rights reserved.
//

import UIKit

//protocol MenuPopupControllerDelegate {
//    func menuPopupController(didEditName: MenuPopupViewController)
//    func menuPopupController(didChangeBackground: MenuPopupViewController)
//    func menuPopupController(didSelect)
//}

class MenuPopupViewController: UIViewController, UINavigationControllerDelegate {
    // Variables
    var menuCells = ["Edit Title", "Edit Background", "Share", "Clear Poem"]
    var selectedCell: String = ""
    var selectedBackground: UIImage!
    
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
// MARK: - Table View DataSource -
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

// MARK: - Table View Delegate -
extension MenuPopupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = menuCells[indexPath.row]
        
        if (menuCells[indexPath.row] == "Edit Background") {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = .photoLibrary
            present(controller, animated: true, completion: nil)
        } else if (menuCells[indexPath.row] == "Share") {
            let image = self.view.takeSnapshot()
            let textToShare = "Share Text"
            let igmWebsite = NSURL(string: "http://igm.rit.edu/")
            let objectsToShare: [AnyObject] = [textToShare as AnyObject, igmWebsite!, image!]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.print]
            
            // These 3 commented out lines will help you on an iPad
            // let popoverMenuViewController = activityVC.popoverPresentationController
            // popoverMenuViewController?.permittedArrowDirections = .any
            // popoverMenuViewController?.barButtonItem = sender as? UIBarButtonItem
            
            self.present(activityVC, animated: true, completion: nil)
        } else {
            exitViewWithSegue()
        }
    }
}

// MARK: - Image Picker Controller Delegate -
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
