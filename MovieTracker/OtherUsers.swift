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
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var myNameField: UILabel!
    @IBOutlet var favouriteActor: UILabel!
    @IBOutlet var favouriteQuote: UILabel!
    @IBOutlet var favouriteMovie: UILabel!
    @IBOutlet var ratingCount: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var rank: UILabel!
    
    
    
    var postData = [String]()
    var filteredData = [String]()
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        Database.database().reference().child("users/"+searchID+"/Movies").observe(.value, with: { (snapshot: DataSnapshot!) in let ratings = (snapshot.childrenCount)
            self.ratingCount.text! = String(ratings)
            if ratings <= 50 {
                self.rank.text! = "New User"
                self.image.image = UIImage(named: "picture5")}
            else if (ratings > 50 && ratings <= 100){
                self.rank.text! = "Amateur"
                self.image.image = UIImage(named: "picture")}
            else if (ratings > 100 && ratings <= 200){
                self.rank.text! = "Casual"
                self.image.image = UIImage(named: "picture6")}
            else if (ratings > 200 && ratings <= 300){
                self.rank.text! = "Initiated"
                self.image.image = UIImage(named: "picture12")}
            else if (ratings > 300 && ratings <= 400){
                self.rank.text! = "Analyst"
                self.image.image = UIImage(named: "picture3")}
            else if (ratings > 400 && ratings <= 500){
                self.rank.text! = "Appraiser"
                self.image.image = UIImage(named: "picture8")}
            else if (ratings > 500 && ratings <= 600){
                self.rank.text! = "Reviewer"
                self.image.image = UIImage(named: "picture9")}
            else if (ratings > 600 && ratings <= 700){
                self.rank.text! = "Critic"
                self.image.image = UIImage(named: "picture4")}
            else if (ratings > 700 && ratings <= 800){
                self.rank.text! = "Veteran"
                self.image.image = UIImage(named: "picture10")}
            else if (ratings > 800 && ratings <= 900){
                self.rank.text! = "Expert"
                self.image.image = UIImage(named: "picture11")}
            else if (ratings > 900 && ratings < 1000){
                self.rank.text! = "Elite"
                self.image.image = UIImage(named: "picture7")}
            else if (ratings >= 1000){
                self.rank.text! = "Connoisseur"
                self.image.image = UIImage(named: "picture2")}
        })
        Database.database().reference().child("users/"+searchID+"/Name").observeSingleEvent(of: .value) {(snapshot) in
            self.myNameField.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favMovie").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteMovie.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favQuote").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteQuote.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/favActor").observeSingleEvent(of: .value) {(snapshot) in
            self.favouriteActor.text = snapshot.value as? String}
        Database.database().reference().child("users/"+searchID+"/Movies").observe(.childAdded) { (Snapshot) in
            let post = Snapshot.value as? String
            if let actualPost = post {
                self.postData.append(actualPost)
                acount = (self.postData.filter{$0.contains("A+,")}).count+(self.postData.filter{$0.contains("A,")}).count+(self.postData.filter{$0.contains("A-,")}).count
                bcount = (self.postData.filter{$0.contains("B+,")}).count+(self.postData.filter{$0.contains("B,")}).count+(self.postData.filter{$0.contains("B-,")}).count
                ccount = (self.postData.filter{$0.contains("C+,")}).count+(self.postData.filter{$0.contains("C,")}).count+(self.postData.filter{$0.contains("C-,")}).count
                dcount = (self.postData.filter{$0.contains("D+,")}).count+(self.postData.filter{$0.contains("D,")}).count+(self.postData.filter{$0.contains("D-,")}).count
                fcount = (self.postData.filter{$0.contains("F,")}).count}
            self.myTableView.reloadData()}
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
