//
//  MovieList.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-12.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase


class MovieList: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    var postData = [String]()
    var filteredData = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching = false
    var acounter = 0
    var bcounter = 0
    var ccounter = 0
    var dcounter = 0
    var fcounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        Database.database().reference().child("users/"+userID+"/Movies").observe(.childAdded) { (Snapshot) in
            let post = Snapshot.value as? String
            if let actualPost = post {
                self.postData.append(actualPost)
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
            fcount = self.fcounter            }
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
                Database.database().reference().child("users/"+userID+"/Movies").child(postData[indexPath.row]).setValue(nil);
                postData.remove(at: indexPath.row)
                myTableView.reloadData()}
            else {
                Database.database().reference().child("users/"+userID+"/Movies").child(filteredData[indexPath.row]).setValue(nil);
                filteredData.remove(at: indexPath.row)
                myTableView.reloadData()
            }
        }
    }
    func tableView(_ tableview: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Viewed Movies"
    }
    override func viewDidAppear(_ animated: Bool) {
        postData.sort()
        myTableView.reloadData()
    }
}
// STRETCH GOALS
// ADD IMDB DESCRIPTIONS
