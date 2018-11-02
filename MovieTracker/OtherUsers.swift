//
//  OtherUsers.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-26.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase


class OtherUsers: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var myNameField: UILabel!
    @IBOutlet var favouriteActor: UILabel!
    @IBOutlet var favouriteQuote: UILabel!
    @IBOutlet var favouriteMovie: UILabel!
    @IBOutlet var ratingCount: UILabel!
    @IBOutlet var rank: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var recommend: UILabel!
    
    var acounter = 0
    var bcounter = 0
    var ccounter = 0
    var dcounter = 0
    var fcounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("users/"+searchID+"/Movies").observe(.value, with: { (snapshot: DataSnapshot!) in let ratings = (snapshot.childrenCount)
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
        Database.database().reference().child("users/"+searchID+"/Name").observeSingleEvent(of: .value) {(snapshot) in
            self.myNameField.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favMovie").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteMovie.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favQuote").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteQuote.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favActor").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteActor.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/recommend").observeSingleEvent(of: .value) {(snapshot) in
            self.recommend.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/Movies").observe(.childAdded) { (Snapshot) in
            let post = Snapshot.value as? String
            if let actualPost = post {
                if actualPost.contains("A+,")||actualPost.contains("A,")||actualPost.contains("A-,"){
                    self.acounter = self.acounter + 1}
                else if actualPost.contains("B+,")||actualPost.contains("B,")||actualPost.contains("B-,"){
                    self.bcounter = self.bcounter + 1}
                else if actualPost.contains("C+,")||actualPost.contains("C,")||actualPost.contains("C-,"){
                    self.ccounter = self.ccounter + 1}
                else if actualPost.contains("D+,")||actualPost.contains("D,")||actualPost.contains("D-,"){
                    self.dcounter = self.dcounter + 1}
                else if actualPost.contains("F,"){
                    self.fcounter = self.fcounter + 1}}
            acount = self.acounter
            bcount = self.bcounter
            ccount = self.ccounter
            dcount = self.dcounter
            fcount = self.fcounter
        }}
    

    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        if nameTextField.text != ""{
            Database.database().reference().child("users/"+searchID).child("Recommended").child(nameTextField.text!+" : "+userID).setValue(nameTextField.text!+" : "+userID)
            nameTextField.text = ""
        }}
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//Recently Added
//Popup notifcation for most recently added
