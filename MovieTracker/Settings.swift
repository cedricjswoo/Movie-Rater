//
//  Settings.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-24.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase


class Settings: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var favmovie: UITextField!
    @IBOutlet weak var favquote: UITextField!
    @IBOutlet weak var favactor: UITextField!
    @IBOutlet weak var ratingPicker: UIPickerView!
    @IBOutlet weak var nameTextField: UILabel!
    var pickerData: [String] = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return pickerData.count}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {return pickerData[row]}
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        nameTextField.text = pickerData[row]
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ratingPicker.delegate = self
        self.ratingPicker.dataSource = self
        pickerData = ["A+,A,A-,B+,B,B-,C+,C,C-,D+,D,D-,F","Liked/Disliked","1,2,3,4,5"]}
    
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
