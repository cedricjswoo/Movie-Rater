//
//  MyLists.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-31.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class MyLists: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    @IBOutlet var pieView: PieChartView!
    @IBOutlet weak var myTableView: UITableView!
    var postData = [String]()
    var filteredData = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        setupPieChart()
        Database.database().reference().child("users/"+userID+"/Recommended").observe(.childAdded) { (Snapshot) in
            let post = Snapshot.value as? String
            if let actualPost = post {
                self.postData.append(actualPost)}
            self.myTableView.reloadData()
        }
    }
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        }
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        if isSearching {
            cell.textLabel?.text =  filteredData[indexPath.row]}
        else {
            cell.textLabel?.text = postData[indexPath.row]}
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            myTableView.reloadData()}
        else {
            isSearching = true
            filteredData = postData.filter{$0.contains(searchBar.text!)}
            myTableView.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if isSearching == false {
                Database.database().reference().child("users/"+userID+"/Recommended").child(postData[indexPath.row]).setValue(nil);
                postData.remove(at: indexPath.row)
                myTableView.reloadData()}
            else {
                Database.database().reference().child("users/"+userID+"/Recommended").child(filteredData[indexPath.row]).setValue(nil);
                filteredData.remove(at: indexPath.row)
                myTableView.reloadData()
            }
        }
    }
    func tableView(_ tableview: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recommended Movies"
    }
    override func viewDidAppear(_ animated: Bool) {
        postData.sort()
        myTableView.reloadData()
    }
}


