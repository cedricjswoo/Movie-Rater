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
    @IBOutlet weak var recent: UILabel!
    
    var acounter = 0
    var bcounter = 0
    var ccounter = 0
    var dcounter = 0
    var fcounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("users/"+searchID+"/Movies").observe(.value, with: { (snapshot: DataSnapshot!) in let ratings = (snapshot.childrenCount)
            self.ratingCount.text! = String(ratings)
            self.rank.text! = ranking[Int(floor(Double(ratings/25)))]})
        Database.database().reference().child("users/"+searchID+"/poster").observeSingleEvent(of: .value) {(snapshot) in
            let wallpaper = snapshot.value as? String
            self.image.image = UIImage(named: wallpaper ?? "picture")}
        Database.database().reference().child("users/"+searchID+"/recent").observeSingleEvent(of: .value) {(snapshot) in
            self.recent.text = snapshot.value as? String}
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

