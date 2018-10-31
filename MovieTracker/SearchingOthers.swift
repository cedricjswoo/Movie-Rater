//
//  SearchingOthers.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-26.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchingOthers: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    var myIndex = 0
    @IBOutlet weak var myTableView: UITableView!
    var postData = [String]()
    var filteredData = [String]()
    var postDataRating = [String]()
    var filteredDataRating = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        Database.database().reference().child("users/userID").observe(.childAdded) { (Snapshot) in
            let post = Snapshot.value as? String
            if let actualPost = post {
                Database.database().reference().child("users/"+actualPost).child("Movies").observe(.value, with: { (snapshot: DataSnapshot!) in let ratingCount = String(snapshot.childrenCount)
                self.postData.append(actualPost)
                self.postDataRating.append(ratingCount+" Ratings"+"  :  "+actualPost)
                self.myTableView.reloadData()
            })
            }}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredDataRating.count
        }
        return postDataRating.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        if isSearching {
            cell.textLabel?.text =  filteredDataRating[indexPath.row]}
        else {
            cell.textLabel?.text = postDataRating[indexPath.row]}
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            myTableView.reloadData()}
        else {
            isSearching = true
            filteredDataRating = postDataRating.filter{$0.contains(searchBar.text!)}
            filteredData = postData.filter{$0.contains(searchBar.text!)}
            myTableView.reloadData()
        }
    }
    @IBAction func searchFriends(_ sender: Any) {
        performSegue(withIdentifier: "visitfriend", sender: self)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if isSearching == false {
            searchID = postData[indexPath.row]}
        else {
            searchID = filteredData[indexPath.row]
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}
