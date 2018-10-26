//
//  Registration.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-24.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Registration: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repassword: UITextField!
    @IBOutlet var alert1: UILabel!
    
    @IBOutlet var alert2: UILabel!
    
    
    @IBAction func register(_ sender: UIButton) {
        userID = username.text!
        Database.database().reference().child("users/"+userID+"/Password").observeSingleEvent(of: .value) {(snapshot) in
            let pword = snapshot.value as? String
            if (pword != nil){
                self.alert1.isHidden = false}
            else if (pword == nil){
                self.alert1.isHidden = true
                if (self.password.text == self.repassword.text){
                    if (self.password.text != ""){
                        Database.database().reference().child("users").child(self.username.text!).child("Password").setValue(self.password.text!)
                        Database.database().reference().child("users").child("userID").child(self.username.text!).setValue(self.username.text!)
                        Database.database().reference().child("users").child(self.username.text!).child("Name").setValue(self.username.text!)
                        
                        
                        
                        self.performSegue(withIdentifier: "settings", sender: self)}}
                else if (self.password.text != self.repassword.text){
                        self.alert1.isHidden = true
                        self.alert2.isHidden = false}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        username.resignFirstResponder()
        password.resignFirstResponder()
        repassword.resignFirstResponder()
        return true
    }

}
