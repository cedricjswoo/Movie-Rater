//
//  ViewController.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-12.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {return pickerData.count}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {return pickerData[row]}
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        nameTextField2.text = pickerData[row]
    }

    @IBOutlet var myNameField: UILabel!
    @IBOutlet var favouriteActor: UILabel!
    @IBOutlet var favouriteQuote: UILabel!
    @IBOutlet var favouriteMovie: UILabel!
    @IBOutlet weak var nameTextField2: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePicker: UIPickerView!
    @IBOutlet var ratingCount: UILabel!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.moviePicker.delegate = self
        self.moviePicker.dataSource = self
        Database.database().reference().child("users/"+userID).child("Movies").observe(.value, with: { (snapshot: DataSnapshot!) in self.ratingCount.text = String(snapshot.childrenCount)
        })
        pickerData = ["NR     ","F,      ","D-,    ","D,     ","D+,   ","C-,    ","C,     ","C+,   ","B-,    ","B,     ","B+,   ","A-,    ","A,     ","A+,   "]
        self.myNameField.text = userID
        Database.database().reference().child("users/"+userID+"/favMovie").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteMovie.text = snapshot.value as? String}
        Database.database().reference().child("users/"+userID+"/favQuote").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteQuote.text = snapshot.value as? String}
        Database.database().reference().child("users/"+userID+"/favActor").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteActor.text = snapshot.value as? String}
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }

    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        if nameTextField.text != ""{
            Database.database().reference().child("users/"+userID).child("Movies")
            Database.database().reference().child("users/"+userID).child("Movies").child(nameTextField2.text! + nameTextField.text!).setValue(nameTextField2.text! + nameTextField.text!)
            nameTextField.text = ""
            Database.database().reference().child("users/"+userID).child("Movies").observe(.value, with: { (snapshot: DataSnapshot!) in self.ratingCount.text = String(snapshot.childrenCount)
                })

        }
       }
}
// STRETCH GOALS
// MAKE PICKER DATA CHANGE WITH OPTION
// MAKE IT SO THAT IMAGE CAN BE CHANGED TO FIREBASE IMAGE
