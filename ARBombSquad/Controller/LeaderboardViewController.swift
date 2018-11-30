//
//  LeaderboardViewController.swift
//  ARBombSquad
//
//  Created by Julie Bao on 11/30/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit
import Parse

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    var usernames:[PFObject] = [] //for the usernames
    
    @IBAction func closeButtonPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usernames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreCell") as! LeaderboardCell
        
//        cell.score = (msgs[indexPath.row]["text"] as? String)!
//        cell.usr = (msgs[indexPath.row]["user"] as? PFObject)?["username"] as? String ?? "EMPTY"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
