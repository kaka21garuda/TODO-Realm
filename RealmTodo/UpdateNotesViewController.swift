//
//  UpdateNotesViewController.swift
//  RealmTodo
//
//  Created by Buka Cakrawala on 4/21/17.
//  Copyright © 2017 Buka Cakrawala. All rights reserved.
//

import UIKit
import RealmSwift

class UpdateNotesViewController: UIViewController {
    
    let realm = try! Realm()
    
    var getNoteDelegate: TransferNoteDataDelegate!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        try! realm.write {
            getNoteDelegate.sendNoteData().title = titleTextField.text!
            getNoteDelegate.sendNoteData().content = contentTextField.text!
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.text = getNoteDelegate.sendNoteData().title
        contentTextField.text = getNoteDelegate.sendNoteData().content
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
