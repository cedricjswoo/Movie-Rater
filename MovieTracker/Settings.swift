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
 
    
    

    @IBOutlet weak var favmovie: UITextField!
    @IBOutlet weak var favquote: UITextField!
    @IBOutlet weak var favactor: UITextField!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var recommendation: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var posterField: UITextField!
    

    @IBAction func forwardselect(_ sender: UIButton) {
       Database.database().reference().child("users/"+userID+"/Movies").observe(.value, with: { (snapshot: DataSnapshot!) in let ratings = (snapshot.childrenCount)
            if selectposter < Int(floor(Double(ratings/25))){
                selectposter += 1
                self.posterField.text! = posters[selectposter]
                self.image.image = UIImage(named: posters[selectposter])
            }
        })}
    
    @IBAction func reverseselect(_ sender: UIButton) {
        if selectposter > 0 {
            selectposter -= 1
            posterField.text! = posters[selectposter]
            image.image = UIImage(named: posters[selectposter])
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: posters[selectposter])
    }
    

    
    @IBAction func homescreen(_ sender: Any) {
        if (posterField.text != ""){
            Database.database().reference().child("users/"+userID+"/poster").setValue(posterField.text)}
        if (favmovie.text != ""){
            Database.database().reference().child("users/"+userID+"/favMovie").setValue(favmovie.text)}
        if (favquote.text != ""){
            Database.database().reference().child("users/"+userID+"/favQuote").setValue(favquote.text)}
        if (favactor.text != ""){
            Database.database().reference().child("users/"+userID+"/favActor").setValue(favactor.text)}
        if (recommendation.text != ""){
            Database.database().reference().child("users/"+userID+"/recommend").setValue(recommendation.text)}}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        favmovie.resignFirstResponder()
        favactor.resignFirstResponder()
        favquote.resignFirstResponder()
        recommendation.resignFirstResponder()
        return true
    }
}
// STRETCH GOALS
// ALLOW PICKER DATA TO CHANGE
