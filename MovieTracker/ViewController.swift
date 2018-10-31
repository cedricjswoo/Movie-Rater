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

    @IBOutlet weak var image: UIImageView!
    @IBOutlet var myNameField: UILabel!
    @IBOutlet var favouriteActor: UILabel!
    @IBOutlet var favouriteQuote: UILabel!
    @IBOutlet var favouriteMovie: UILabel!
    @IBOutlet weak var nameTextField2: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePicker: UIPickerView!
    @IBOutlet var ratingCount: UILabel!
    @IBOutlet weak var rank: UILabel!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.moviePicker.delegate = self
        self.moviePicker.dataSource = self
        Database.database().reference().child("users/"+userID+"/Movies").observe(.value, with: { (snapshot: DataSnapshot!) in let ratings = (snapshot.childrenCount)
            self.ratingCount.text! = String(ratings)
            if ratings <= 50 {
                self.rank.text! = "New User"
                self.image.image = UIImage(named: "picture5")}
            else if (ratings > 50 && ratings <= 100){
                self.rank.text! = "Amateur"
                self.image.image = UIImage(named: "picture")}
            else if (ratings > 100 && ratings <= 200){
                self.rank.text! = "Casual"
                self.image.image = UIImage(named: "picture6")}
            else if (ratings > 200 && ratings <= 300){
                self.rank.text! = "Initiated"
                self.image.image = UIImage(named: "picture12")}
            else if (ratings > 300 && ratings <= 400){
                self.rank.text! = "Analyst"
                self.image.image = UIImage(named: "picture3")}
            else if (ratings > 400 && ratings <= 500){
                self.rank.text! = "Appraiser"
                self.image.image = UIImage(named: "picture8")}
            else if (ratings > 500 && ratings <= 600){
                self.rank.text! = "Reviewer"
                self.image.image = UIImage(named: "picture9")}
            else if (ratings > 600 && ratings <= 700){
                self.rank.text! = "Critic"
                self.image.image = UIImage(named: "picture4")}
            else if (ratings > 700 && ratings <= 800){
                self.rank.text! = "Veteran"
                self.image.image = UIImage(named: "picture10")}
            else if (ratings > 800 && ratings <= 900){
                self.rank.text! = "Expert"
                self.image.image = UIImage(named: "picture11")}
            else if (ratings > 900 && ratings < 1000){
                self.rank.text! = "Elite"
                self.image.image = UIImage(named: "picture7")}
            else if (ratings >= 1000){
                self.rank.text! = "Connoisseur"
                self.image.image = UIImage(named: "picture2")}
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
            Database.database().reference().child("users/"+userID).child("Movies").child(nameTextField2.text! + nameTextField.text!).setValue(nameTextField2.text! + nameTextField.text!)
            nameTextField.text = ""
            Database.database().reference().child("users/"+userID).child("Movies").observe(.value, with: { (snapshot: DataSnapshot!) in self.ratingCount.text = String(snapshot.childrenCount)
                })}}
    
    @IBAction func recommend(_ sender: UIButton) {
        if nameTextField.text != ""{
            Database.database().reference().child("users/"+userID).child("Recommended").child( nameTextField.text!).setValue(nameTextField.text!)
            nameTextField.text = ""
        }}
}
// STRETCH GOALS
// MAKE IT SO THAT IMAGE CAN BE CHANGED TO FIREBASE IMAGE
