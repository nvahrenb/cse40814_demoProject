//
//  ViewController.swift
//  demoProject
//
//  Created by Nathan Vahrenberg on 10/13/15.
//  Copyright © 2015 Nathan Vahrenberg. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get keyboard notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        // Firebase url
        let myRootRef = Firebase(url:"https://vivid-heat-1028.firebaseio.com")
        
        // Read data and react to changes
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            print("\(snapshot.key) -> \(snapshot.value)")
            self.myLabel.text = snapshot.value as! String
        })
        
    }
    
    deinit {
        // Un-get keyboard notifications
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
   // Called when button is pressed
   @IBAction func sendData(sender: AnyObject){
    
        // Get textfield string
        let myString = myTextField.text
    
        // Write data to Firebase
        let myRootRef = Firebase(url:"https://vivid-heat-1028.firebaseio.com")
        myRootRef.setValue(myString)
    
        // Clear text field
        myTextField.text = ""
        
    }
    
    // Makes the text field move when keyboard is shown. I don't understand how it works, I just found it on the internet
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            UIView.animateWithDuration(duration,
                delay: NSTimeInterval(0),
                options: animationCurve,
                animations: { self.view.layoutIfNeeded() },
                completion: nil)
        }
    }

}

