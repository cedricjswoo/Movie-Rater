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
                self.postData.append(actualPost)
                self.myTableView.reloadData()
            }
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            Database.database().reference().child("users/userID").child(postData[indexPath.row]).setValue(nil);
            print(postData[indexPath.row])
            postData.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        postData.sort()
        myTableView.reloadData()
    }
}
