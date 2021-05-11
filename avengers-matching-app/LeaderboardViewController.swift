//
//  LeaderboardViewController.swift
//  Adatia_Shayn_MatchingApp
//
//  Created by Jebin Adatia on 2019-05-19.
//  Copyright © 2019 Period Two. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedSegment = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentPanel: UISegmentedControl!
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    var myArray: [String] = []
    
    var myArray2: [String] = []
    
    var numberOfRows = 0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch segmentPanel.selectedSegmentIndex {
        case 0:
            numberOfRows = myArray.count
        case 1:
            numberOfRows = myArray2.count
        default:
            break
        }
        
        return numberOfRows
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Leaderboard"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myReusedCell", for: indexPath)
        
        switch segmentPanel.selectedSegmentIndex {
        case 0:
            myCell.textLabel?.text = myArray[indexPath.row]
        case 1:
            myCell.textLabel?.text = myArray2[indexPath.row]
        default:
            break
        }
        
        return myCell
        
    }
    
    func loadData() {
        if let loadNames: [String] = UserDefaults.standard.value(forKey: "save") as? [String] {
            myArray = loadNames
        }
        
        myArray = myArray.sorted()
        myArray = myArray.reversed()
    }
    
    func loadData2() {
        if let loadNames2: [String] = UserDefaults.standard.value(forKey: "save2") as? [String] {
            myArray2 = loadNames2
        }
        
        myArray2 = myArray2.sorted()
        myArray2 = myArray2.reversed()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        loadData()
        loadData2()

    }
    
    
}

