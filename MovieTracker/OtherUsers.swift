//
//  OtherUsers.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-26.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OtherUsers: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet var myNameField: UILabel!
    @IBOutlet var favouriteActor: UILabel!
    @IBOutlet var favouriteQuote: UILabel!
    @IBOutlet var favouriteMovie: UILabel!
    @IBOutlet var ratingCount: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var postData = [String]()
    var filteredData = [String]()
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        Database.database().reference().child("users/"+searchID+"/Movies").observe(.childAdded) { (Snapshot) in
            let post = Snapshot.value as? String
            if let actualPost = post {
                self.postData.append(actualPost)
                self.myTableView.reloadData()}}
        Database.database().reference().child("users/"+searchID+"/Movies").observe(.value, with: { (snapshot: DataSnapshot!) in self.ratingCount.text = String(snapshot.childrenCount)
        })
        Database.database().reference().child("users/"+searchID+"/Name").observeSingleEvent(of: .value) {(snapshot) in
            self.myNameField.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favMovie").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteMovie.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favQuote").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteQuote.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favActor").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteActor.text = snapshot.value as? String}
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
    

    override func viewDidAppear(_ animated: Bool) {
        postData.sort()
        myTableView.reloadData()
    }
}
