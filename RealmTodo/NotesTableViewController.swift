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
    
    // chosenNote will be the Note object from allNotes, that will be chosen from selecting tableView cell
    var chosenNote: Note!
    
    let realm = try! Realm()
    let allNotes = (try! Realm()).objects(Note.self)
    
    // alert controller consists of 2 textFields and 2 actions in order to add/write item into realm
    let alertController = UIAlertController(title: "Add", message: "", preferredStyle: .alert)

    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
    }
    
    // return chosenNote
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
            
            // make a new note object
            let newNote = Note()
            newNote.title = (titleTextField?.text)!
            newNote.content = (contentTextField?.text)!
            // dateString will be the date of that Note being uploaded in type string
            newNote.dateString = Date().description
            
            try! self.realm.write({
                self.realm.add(newNote)
            })
            
            // dismiss alertView and reloadData
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
    
    //MARK: - View Life Cycle
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // before perform a segue,
        if segue.identifier == "updateNoteSegue" {
            let updateViewController = segue.destination as! UpdateNotesViewController
            // set the delegate to self, to transfer the data of chosenNote into the updateViewController
            updateViewController.getNoteDelegate = self
        }
    }

    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return only one section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of notes
        return allNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell!
        
        // sort allNotes by descending order, to get the recent notes come first
        let sortedNotes = allNotes.sorted(byKeyPath: "dateString", ascending: false)
        
        
        cell?.textLabel?.text = sortedNotes[indexPath.row].title
        cell?.detailTextLabel?.text = sortedNotes[indexPath.row].content
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // chosenNote will be the note object selected from the tableView cell
        chosenNote = allNotes[indexPath.row]
        
        // perform a segue, into the updateViewController to update item
        self.performSegue(withIdentifier: "updateNoteSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // when the user is swiping left to delete item,
        if editingStyle == .delete {
            
            try! realm.write({
                // delete the specific item according to its indexPath from realm
                realm.delete(allNotes[indexPath.row])
                // reload the tableView data
                tableView.reloadData()
            })
        }
    }
}
