//
//  NotesTableViewController.swift
//  RealmTodo
//
//  Created by Buka Cakrawala on 4/21/17.
//  Copyright © 2017 Buka Cakrawala. All rights reserved.
//

import UIKit
import RealmSwift

class NotesTableViewController: UITableViewController {
    
    var roundButton = UIButton()
    
    let realm = try! Realm()
    
    let alertController = UIAlertController(title: "Add", message: "", preferredStyle: .alert)

    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func setupAlertView() {
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            let titleTextField = self.alertController.textFields?[0]
            let contentTextField = self.alertController.textFields?[1]
            
            let newNote = Note()
            newNote.title = (titleTextField?.text)!
            newNote.content = (contentTextField?.text)!
            newNote.dateString = Date().description
            
            try! self.realm.write({
                self.realm.add(newNote)
            })
            
            self.dismiss(animated: true, completion: nil)
            self.tableView.reloadData()
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let allNotes = realm.objects(Note)
        return allNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell!
        let allNotes = realm.objects(Note)
        
        
        
        cell?.textLabel?.text = allNotes[indexPath.row].title
        cell?.detailTextLabel?.text = allNotes[indexPath.row].content
        
        return cell!
    }


}
