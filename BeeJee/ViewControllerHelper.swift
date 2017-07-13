//
//  ViewControllerHelper.swift
//  BeeJee
//
//  Created by infuntis on 02/07/17.
//  Copyright © 2017 gala. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftyJSON

extension ViewController{
    func clearData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Contact.fetchRequest())
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error while clearing data")
        }
    }
    
    func setupData(){
        clearData()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    for (_, object) in jsonObj["contacts"]{
                        let contact = Contact(context: context)
                        contact.contactID = UUID().uuidString
                        contact.lastName = object["lastName"].stringValue
                        contact.firstName = object["firstName"].stringValue
                        contact.phoneNumber = object["phoneNumber"].stringValue
                        contact.city = object["address"]["city"].stringValue
                        contact.streetAddress1 = object["address"]["streetAddress1"].stringValue
                        contact.streetAddress2 = object["address"]["streetAddress2"].stringValue
                        contact.state = object["address"]["state"].stringValue
                        contact.zipCode = object["address"]["postalCode"].stringValue
                        try(context.save())
                    }
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error)
            }
        } else {
            print("Invalid filename/path.")
        }
        loadData()
        
    }
    
    func loadData() {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        if let context = context {
            do {
                let fec:NSFetchRequest = Contact.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
                fec.sortDescriptors = [sortDescriptor]
                contacts = try(context.fetch(fec))
            } catch let error {
                print(error)
            }
            
        }
    }
    
    func saveData(){
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}
