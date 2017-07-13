//
//  ViewController.swift
//  BeeJee
//
//  Created by infuntis on 02/07/17.
//  Copyright © 2017 gala. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        setupData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddContact":
            print("Add a new contact")
            
        case "ShowContact":
            guard let contactDetailViewController = segue.destination as? ContactViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedContactCell = sender as? ContactTableCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedContactCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedContact = contacts[indexPath.row]
            contactDetailViewController.contact = selectedContact
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    @IBAction func unwindToContactList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ContactViewController, let contact = sourceViewController.contact {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                contacts[selectedIndexPath.row] = contact
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                saveData()
            }
            else {
                let newIndexPath = IndexPath(row: contacts.count, section: 0)
                contacts.append(contact)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                saveData()
            }
            
        }
    }
    
    
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contact = contacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell",
                                                 for: indexPath)
        cell.textLabel?.text = "\(contact.value(forKeyPath: "firstName") as! String) \(contact.value(forKeyPath: "lastName") as! String)"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    
}

class ContactTableCell: UITableViewCell{
    
}

