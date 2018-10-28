//
//  Settings.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-24.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase


class Settings: UIViewController{
 
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repassword: UITextField!
    @IBOutlet weak var favmovie: UITextField!
    @IBOutlet weak var favquote: UITextField!
    @IBOutlet weak var favactor: UITextField!
    @IBOutlet var notification: UILabel!
    @IBOutlet weak var nameTextField: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification.isHidden = true
    }
    
    @IBAction func changepass(_ sender: UIButton) {
        if password.text != "" {
            if password.text != repassword.text {
                notification.isHidden = false
            }
            else {
                Database.database().reference().child("users/"+userID+"/Password").setValue(password.text)
                notification.isHidden = true
                password.text = ""
                repassword.text = ""
            }
        }
    }
    
    @IBAction func homescreen(_ sender: Any) {
        if (favmovie.text != ""){
            Database.database().reference().child("users/"+userID+"/favMovie").setValue(favmovie.text)}
        if (favquote.text != ""){
            Database.database().reference().child("users/"+userID+"/favQuote").setValue(favquote.text)}
        if (favactor.text != ""){
            Database.database().reference().child("users/"+userID+"/favActor").setValue(favactor.text)}}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        favmovie.resignFirstResponder()
        favactor.resignFirstResponder()
        favquote.resignFirstResponder()
        return true
    }
}
// STRETCH GOALS
// ALLOW PICKER DATA TO CHANGE
// CHANGE YOUR USERNAME/PASSWORD HERE
