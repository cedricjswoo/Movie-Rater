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
            if ratings < 25 {
                self.rank.text! = "New User"
                self.image.image = UIImage(named: "picture5")}
            else if (ratings >= 25 && ratings <= 50) {
                self.rank.text! = "Beginner"
                self.image.image = UIImage(named: "picture13")}
            else if (ratings > 50 && ratings <= 75){
                self.rank.text! = "Amateur I"
                self.image.image = UIImage(named: "picture")}
            else if (ratings > 75 && ratings <= 100){
                self.rank.text! = "Amateur II"
                self.image.image = UIImage(named: "picture14")}
            else if (ratings > 100 && ratings <= 125){
                self.rank.text! = "Casual I"
                self.image.image = UIImage(named: "picture15")}
            else if (ratings > 125 && ratings <= 150){
                self.rank.text! = "Casual II"
                self.image.image = UIImage(named: "picture16")}
            else if (ratings > 150 && ratings <= 175){
                self.rank.text! = "Casual III"
                self.image.image = UIImage(named: "picture17")}
            else if (ratings > 175 && ratings <= 200){
                self.rank.text! = "Casual IV"
                self.image.image = UIImage(named: "picture6")}
            else if (ratings > 200 && ratings <= 225){
                self.rank.text! = "Initiated I"
                self.image.image = UIImage(named: "picture18")}
            else if (ratings > 225 && ratings <= 250){
                self.rank.text! = "Initiated II"
                self.image.image = UIImage(named: "picture12")}
            else if (ratings > 250 && ratings <= 275){
                self.rank.text! = "Initiated III"
                self.image.image = UIImage(named: "picture20")}
            else if (ratings > 275 && ratings <= 300){
                self.rank.text! = "Initiated IV"
                self.image.image = UIImage(named: "picture19")}
            else if (ratings > 300 && ratings <= 325){
                self.rank.text! = "Analyst I"
                self.image.image = UIImage(named: "picture21")}
            else if (ratings > 325 && ratings <= 350){
                self.rank.text! = "Analyst II"
                self.image.image = UIImage(named: "picture22")}
            else if (ratings > 350 && ratings <= 375){
                self.rank.text! = "Analyst III"
                self.image.image = UIImage(named: "picture23")}
            else if (ratings > 375 && ratings <= 400){
                self.rank.text! = "Analyst IV"
                self.image.image = UIImage(named: "picture3")}
            else if (ratings > 400 && ratings <= 425){
                self.rank.text! = "Apprasier I"
                self.image.image = UIImage(named: "picture24")}
            else if (ratings > 425 && ratings <= 450){
                self.rank.text! = "Apprasier II"
                self.image.image = UIImage(named: "picture25")}
            else if (ratings > 450 && ratings <= 475){
                self.rank.text! = "Apprasier III"
                self.image.image = UIImage(named: "picture26")}
            else if (ratings > 475 && ratings <= 500){
                self.rank.text! = "Appraiser IV"
                self.image.image = UIImage(named: "picture8")}
            else if (ratings > 500 && ratings <= 525){
                self.rank.text! = "Reviewer I"
                self.image.image = UIImage(named: "picture27")}
            else if (ratings > 525 && ratings <= 550){
                self.rank.text! = "Reviewer II"
                self.image.image = UIImage(named: "picture28")}
            else if (ratings > 550 && ratings <= 575){
                self.rank.text! = "Reviewer III"
                self.image.image = UIImage(named: "picture29")}
            else if (ratings > 575 && ratings <= 600){
                self.rank.text! = "Reviewer IV"
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
//UPDATES
//Make Movie Selection An Array
//Progress Bar
//Add Constraints for everything
//Save most recently saved


// STRETCH GOALS
// MAKE IT SO THAT IMAGE CAN BE CHANGED TO FIREBASE IMAGE
