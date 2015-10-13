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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a reference to a Firebase location
        let myRootRef = Firebase(url:"https://vivid-heat-1028.firebaseio.com")
        
        // Read data and react to changes
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            print("\(snapshot.key) -> \(snapshot.value)")
            self.myLabel.text = snapshot.value as! String
        })
        
    }
    
   @IBAction func sendData(sender: AnyObject){
       
        let myString = myTextField.text
        let myRootRef = Firebase(url:"https://vivid-heat-1028.firebaseio.com")
        // Write data to Firebase
        myRootRef.setValue(myString)
        myTextField.text = ""
        
    }

}

