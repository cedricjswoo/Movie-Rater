//
//  ViewController.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-12.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase
var wallpaper = "picture"
var selectposter = 0
var ranking:[String] = ["New User","Beginner","Amateur I","Amateur II","Casual I","Casual II","Casual III","Casual IV","Initiated I","Initiated II","Initiated III","Initiated IV","Analyst I","Analyst II","Analyst III","Analyst IV","Appraiser I","Appraiser II","Appraiser III","Appraiser IV","Reviewer I","Reviewer II","Reviewer III","Reviewer IV","Critic I","Critic II","Critic III","Critic IV","Veteran I","Veteran II","Veteran III","Veteran IV","Expert I","Expert II","Expert III","Expert IV","Elite I","Elite II","Elite III","Elite IV","Connoisseur"]
var posters:[String] = ["picture","picture2","picture3","picture4","picture5","picture6","picture7","picture8","picture9","picture10","picture11","picture12","picture13","picture14","picture15","picture16","picture17","picture18","picture19","picture20","picture21","picture22","picture23","picture24","picture25","picture26","picture27","picture28","picture29","picture30","picture31","picture32","picture33","picture34","picture35","picture36","picture37","picture38","picture39","picture40","picture41"]

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
    @IBOutlet weak var progressview: UIView!
    var selectableposters:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.moviePicker.delegate = self
        self.moviePicker.dataSource = self
        Database.database().reference().child("users/"+userID+"/Movies").observe(.value, with: { (snapshot: DataSnapshot!) in let ratings = (snapshot.childrenCount)
            self.ratingCount.text! = String(ratings)
            self.rank.text! = ranking[Int(floor(Double(ratings/25)))]
            let shapeLayer = CAShapeLayer()
            let center = self.progressview.center
            let tracklayer = CAShapeLayer()
            let circularPath = UIBezierPath(arcCenter: center, radius: 57.00, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
            print (remainder)
            tracklayer.path = circularPath.cgPath
            tracklayer.strokeColor = UIColor.lightGray.cgColor
            tracklayer.lineWidth = 10
            tracklayer.fillColor = UIColor.clear.cgColor
            tracklayer.lineCap = CAShapeLayerLineCap.round
            self.view.layer.addSublayer(tracklayer)
            shapeLayer.path = circularPath.cgPath
            shapeLayer.strokeColor = UIColor.yellow.cgColor
            shapeLayer.lineWidth = 10
            shapeLayer.strokeEnd = CGFloat(Double(ratings%25)*0.04)
            shapeLayer.lineCap = CAShapeLayerLineCap.round
            shapeLayer.fillColor = UIColor.clear.cgColor
            self.view.layer.addSublayer(shapeLayer)
        })
        
        pickerData = ["NR     ","F,      ","D-,    ","D,     ","D+,   ","C-,    ","C,     ","C+,   ","B-,    ","B,     ","B+,   ","A-,    ","A,     ","A+,   "]
        self.myNameField.text = userID
        Database.database().reference().child("users/"+userID+"/favMovie").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteMovie.text = snapshot.value as? String}
        Database.database().reference().child("users/"+userID+"/favQuote").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteQuote.text = snapshot.value as? String}
        Database.database().reference().child("users/"+userID+"/favActor").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteActor.text = snapshot.value as? String}
        Database.database().reference().child("users/"+userID+"/poster").observeSingleEvent(of: .value) {(snapshot) in
            let wallpaper = snapshot.value as? String
            self.image.image = UIImage(named: wallpaper ?? "picture")}
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
            Database.database().reference().child("users/"+userID+"/recent").setValue(nameTextField2.text! + nameTextField.text!)
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
