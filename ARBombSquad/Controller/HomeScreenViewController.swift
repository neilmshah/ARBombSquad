//
//  HomeScreenViewController.swift
//  The Balloon Game
//
//  Created by Akshat Goel on 13/12/17.
//  Copyright © 2017 starksky. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "homeToLevelSegue", sender: self)
    }
    

}
