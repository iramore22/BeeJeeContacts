//
//  ContactViewController.swift
//  BeeJee
//
//  Created by infuntis on 02/07/17.
//  Copyright © 2017 gala. All rights reserved.
//

import Foundation
import UIKit

class ContactViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var firstnameTF: UITextField!
    
    @IBOutlet weak var phonenumberTF: UITextField!
    @IBOutlet weak var streetLine1TF: UITextField!
    @IBOutlet weak var streetLine2TF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var zipCodeTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    var activeField: UITextField?
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        updateSaveButtonState()
        
        if let contact = contact {
            navigationItem.title = contact.lastName
            lastnameTF.text = contact.lastName
            firstnameTF.text = contact.firstName
            phonenumberTF.text = contact.phoneNumber
            streetLine1TF.text = contact.streetAddress1
            streetLine2TF.text = contact.streetAddress2 == "" ? " " : contact.streetAddress2
            cityTF.text = contact.city
            zipCodeTF.text = contact.zipCode
            stateTF.text = contact.state
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        let isPresentingInAddContactMode = presentingViewController is UINavigationController
        
        if isPresentingInAddContactMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ContactViewController is not inside a navigation controller.")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveBtn else {
            print("Save button wasn't pressed - cancelling")
            return
        }
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        contact = Contact(context: context)
        contact!.contactID = UUID().uuidString
        contact!.lastName = lastnameTF.text
        contact!.firstName = firstnameTF.text
        contact!.phoneNumber = phonenumberTF.text
        contact!.city = cityTF.text
        contact!.streetAddress1 = streetLine1TF.text
        contact!.streetAddress2 = streetLine2TF.text
        contact!.state = ""
        contact!.zipCode = zipCodeTF.text
        
       
    }
}
