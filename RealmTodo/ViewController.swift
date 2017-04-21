//
//  ViewController.swift
//  RealmTodo
//
//  Created by Buka Cakrawala on 4/21/17.
//  Copyright © 2017 Buka Cakrawala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let alertController = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
    
    
    

    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func setupAlertView() {
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            let titleTextField = self.alertController.textFields?[0]
            let contentTextField = self.alertController.textFields?[1]
            print("\(String(describing: titleTextField?.text)) is \(String(describing: contentTextField?.text))")
            self.dismiss(animated: true, completion: nil)
        }
        
        // textfield to input the title are added into the alertController
        alertController.addTextField { (titleField) in
            titleField.placeholder = "Enter your title..."
            
        }
        
        // textfield to input the content are added into the alertController
        alertController.addTextField { (contentField) in
            contentField.placeholder = "Enter your content..."
        }
        
        // add both action into the alertController, save and cancel
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAlertView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

