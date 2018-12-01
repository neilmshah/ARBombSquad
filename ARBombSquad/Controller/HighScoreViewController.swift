//
//  HighScoreViewController.swift
//  ARBombSquad
//
//  Created by Neil Shah on 11/30/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit
import Parse

class HighScoreViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var userInfo: [UserInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        fetchScores()
    }
    
    @objc func fetchScores() {
        let query = UserInfo.query()
        query?.order(byDescending: "score")
        
        query?.findObjectsInBackground(block: { (userInfo, error) in
            if let userInfo = userInfo {
                self.userInfo = userInfo as! [UserInfo]
                self.tableView.reloadData()
            }
            else {
                print("Could not fetchScores")
                print(error.debugDescription)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath) as! HighScoreCell
        let info = userInfo[indexPath.row]
        
        cell.nameLabel.text = PFUser.current()?.username
        cell.scoreLabel.text = info.score
        
        return cell
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
