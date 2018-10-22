//
//  MovieList.swift
//  MovieTracker
//
//  Created by Cedric Woo on 2018-10-12.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit

class MovieList: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mymovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = (mymovies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            mymovies.remove(at: indexPath.row)
            UserDefaults.standard.set(mymovies, forKey: "moviekey")
            myTableView.reloadData()
        }
    }

    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableview: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Viewed Movies"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        mymovies.sort()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
