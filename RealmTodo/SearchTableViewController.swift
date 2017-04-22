//
//  SearchTableViewController.swift
//  
//
//  Created by Buka Cakrawala on 4/21/17.
//
//

import UIKit
import RealmSwift

class SearchTableViewController: UITableViewController {
    
    let allNotes = (try! Realm()).objects(Note.self)
    
    var filteredNotes = [Note]()
    var unfilteredNotes = [Note]()
    
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for note in allNotes.sorted(byKeyPath: "dateString", ascending: false) {
            unfilteredNotes.append(note)
        }

        setupSearchBar()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // the number of rows return, is the number of elements in the filteredNotes
        return filteredNotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        // note object according to array index
        let note = filteredNotes[indexPath.row]
        // cell titleLabel text, from the note's title
        searchCell.textLabel?.text = note.title
        // cell detailLabel text, from the note's content
        searchCell.detailTextLabel?.text = note.content
        return searchCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // after selecting a cell, dismiss the viewController to go back to the homeView
        dismiss(animated: true, completion: nil)
    }
    
}

extension SearchTableViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    //MARK: - Setup Search Bar
    func setupSearchBar() {
    
        // Setting all the searchController property; delegate, resultsUpdater and other navigationBar property
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        // place the searchbar in the titleView of the navigationBar, or in the middle
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        // add UITextField into the searchController
        let textField = searchController.searchBar.value(forKey: "searchField") as! UITextField
        textField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 0.9)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    //MARK: - Update Search Results
    // this function will be executed whenever the user made changes with textField's text inside the searchController
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            // if the text inside textField is not empty,
            // set the dimBackgroundPresentation to false, so that the tableViewCell is clickable.
            self.searchController.dimsBackgroundDuringPresentation = false
            
            // filter unfiltered array, with the given title typed by the user in the searchController's textField
            filteredNotes = unfilteredNotes.filter({ (note) -> Bool in
                return note.title.lowercased().contains(searchText.lowercased())
            })
            
            
        } else {
            // if there's no text in the textField, then just return the unfiltered version
            filteredNotes = unfilteredNotes
            // reload tableView
            tableView.reloadData()
        }
        
        tableView.reloadData()
        
    }
}
