//
//  Login Page.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-24.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase
var userID = ""
var searchID = ""

class Login_Page: UIViewController,UITextFieldDelegate {

    
    
    @IBOutlet weak var loginUser: UITextField!
    @IBOutlet weak var loginPass: UITextField!
    @IBOutlet weak var newUser: UIButton!
    @IBOutlet var alerttext: UILabel!
    
    @IBAction func login(_ sender: UIButton) {
        userID = loginUser.text!
        Database.database().reference().child("users/"+userID+"/Password").observeSingleEvent(of: .value) {(snapshot) in
            let pword = snapshot.value as? String
            if (pword == self.loginPass.text!){
                UserDefaults.standard.set(self.loginUser.text!,forKey: "autologuser")
                UserDefaults.standard.set(self.loginPass
                    .text!,forKey: "autologpass")
                self.performSegue(withIdentifier: "homeview", sender: self)}
            if (pword != self.loginPass.text!){
                self.alerttext.isHidden = false}
        }
    }
    
    override func viewDidLoad() {        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let ucreds = UserDefaults.standard.object(forKey: "autologuser") as? String{
            loginUser.text = ucreds
        }
        if let pcreds = UserDefaults.standard.object(forKey: "autologpass") as? String{
            loginPass.text = pcreds
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginUser.resignFirstResponder()
        loginPass.resignFirstResponder()
        return true
    }

}
