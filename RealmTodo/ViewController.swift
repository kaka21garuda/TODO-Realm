//
//  ViewController.swift
//  RealmTodo
//
//  Created by Buka Cakrawala on 4/21/17.
//  Copyright © 2017 Buka Cakrawala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

