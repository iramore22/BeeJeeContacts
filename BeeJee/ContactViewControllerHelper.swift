//
//  ContactViewControllerHelper.swift
//  BeeJee
//
//  Created by infuntis on 02/07/17.
//  Copyright © 2017 gala. All rights reserved.
//

import Foundation
import UIKit

extension ContactViewController: UITextFieldDelegate{
    
    func setDelegates(){
        streetLine1TF.delegate = self
        streetLine2TF.delegate = self
        cityTF.delegate = self
        zipCodeTF.delegate = self
        stateTF.delegate = self
        lastnameTF.delegate = self
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == streetLine1TF || textField == streetLine2TF || textField == zipCodeTF || textField == cityTF || textField == stateTF{
            animateViewMoving(up: true, moveValue: 130)
        }
        if textField == lastnameTF {
            saveBtn.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == streetLine1TF || textField == streetLine2TF || textField == zipCodeTF || textField == cityTF || textField == stateTF{
            animateViewMoving(up: false, moveValue: 130)
        }
        if textField == lastnameTF {
            updateSaveButtonState()
            navigationItem.title = textField.text
        }
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func updateSaveButtonState() {
        
        let text = lastnameTF.text ?? ""
        saveBtn.isEnabled = !text.isEmpty
    }

}
