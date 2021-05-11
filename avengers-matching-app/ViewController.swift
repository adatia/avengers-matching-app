//
//  ViewController.swift
//  Adatia_Shayn_MatchingApp
//
//  Created by Period Two on 2019-05-02.
//  Copyright © 2019 Period Two. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToMainMenu(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
}
