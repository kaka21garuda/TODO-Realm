//
//  NotesTableViewController.swift
//  RealmTodo
//
//  Created by Buka Cakrawala on 4/21/17.
//  Copyright © 2017 Buka Cakrawala. All rights reserved.
//

import UIKit
import RealmSwift

protocol TransferNoteDataDelegate {
    
    func sendNoteData() -> Note
    
}

class NotesTableViewController: UITableViewController, TransferNoteDataDelegate {
    
    var chosenIndexPath: IndexPath!
    
    var chosenNote: Note!
    
    var roundButton = UIButton()
    
    let realm = try! Realm()
    
    let alertController = UIAlertController(title: "Add", message: "", preferredStyle: .alert)

    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func sendNoteData() -> Note {
        return chosenNote
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
        
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
        let sortedNotes = allNotes.sorted(byKeyPath: "dateString", ascending: false)
        
        
        cell?.textLabel?.text = sortedNotes[indexPath.row].title
        cell?.detailTextLabel?.text = sortedNotes[indexPath.row].content
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let allNotes = realm.objects(Note)
        
        if editingStyle == .delete {
            try! realm.write({
                realm.delete(allNotes[indexPath.row])
                tableView.reloadData()
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let allNotes = realm.objects(Note)
        
        if segue.identifier == "updateNoteSegue" {
            let updateViewController = segue.destination as! UpdateNotesViewController
            updateViewController.getNoteDelegate = self
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let allNotes = realm.objects(Note)
        chosenNote = allNotes[indexPath.row]
        self.performSegue(withIdentifier: "updateNoteSegue", sender: self)
    }


}
