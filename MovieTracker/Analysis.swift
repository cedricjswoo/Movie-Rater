//
//  Analysis.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-31.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class Analysis: UIViewController {
    @IBOutlet var pieView: PieChartView!
    @IBOutlet var myNameField: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    func setupPieChart(){
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = false
        pieView.rotationAngle = 0
        pieView.rotationEnabled = false
        pieView.isUserInteractionEnabled = false
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: Double(acount), label: String(acount)+" A's"))
        entries.append(PieChartDataEntry(value: Double(bcount), label: String(bcount)+" B's"))
        entries.append(PieChartDataEntry(value: Double(ccount), label: String(ccount)+" C's"))
        entries.append(PieChartDataEntry(value: Double(dcount), label: String(dcount)+" D's"))
        entries.append(PieChartDataEntry(value: Double(fcount), label: String(fcount)+" F's"))
        
        let dataSet = PieChartDataSet(values: entries, label: "")
        let c1 = NSUIColor(displayP3Red: 100, green: 0, blue: 0, alpha: 100)
        let c2 = NSUIColor(displayP3Red: 0, green: 150, blue: 0, alpha: 100)
        let c3 = NSUIColor(displayP3Red: 0, green: 0, blue: 50, alpha: 100)
        let c4 = NSUIColor(displayP3Red: 100, green: 0, blue: 100, alpha: 100)
        let c5 = NSUIColor(displayP3Red: 0, green: 100, blue: 100, alpha: 100)
        dataSet.colors = [c1,c2,c3,c4,c5]
        dataSet.drawValuesEnabled = false
        pieView.data = PieChartData(dataSet: dataSet)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("users/"+searchID+"/Name").observeSingleEvent(of: .value) {(snapshot) in
            self.myNameField.text = snapshot.value as? String}
        setupPieChart()
    }
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        if nameTextField.text != ""{
            Database.database().reference().child("users/"+searchID).child("Recommended").child( nameTextField.text!).setValue(nameTextField.text!)
            nameTextField.text = ""
            }}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}
