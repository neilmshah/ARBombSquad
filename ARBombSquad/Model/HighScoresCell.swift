//
//  HighScoresCell.swift
//  ARBombSquad
//
//  Created by Neil Shah on 11/30/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import Foundation

class HighScoreCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
