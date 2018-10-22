//
//  ViewController.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-12.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit

//Variables
var mymovies = UserDefaults.standard.stringArray(forKey: "moviekey") ?? [String] ()

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    //Initializaing Fields of pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {return pickerData.count}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {return pickerData[row]}
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        nameTextField2.text = pickerData[row]
    }

    //Setting Fields
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
        ratingCount.text = String(mymovies.count)
        //Setting Picker Field
        pickerData = ["NR","F","D-","D,","D+","C-","C,","C+","B-","B,","B+","A-","A,","A+"]
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
            mymovies.append(nameTextField2.text! + "\t:\t" + nameTextField.text!)
            UserDefaults.standard.set(mymovies, forKey: "moviekey")
            nameTextField.text = ""
            ratingCount.text = String(mymovies.count)

        }
       }
    
}

