//
//  LeaderboardCell.swift
//  Bolts
//
//  Created by Julie Bao on 11/30/18.
//

import UIKit

class LeaderboardCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var usr: String = ""
    {
        didSet{
            username.text = usr
        }
    }
    
    public var scre: String = ""
    {
        didSet{
            score.text = scre
        }
    }
    
//    public var rnk: Int
//    {
//        didSet{
//            rnk = rnk + 1
//            rank.text = toString(rnk)
//        }
//        //otherwise start with rank 1
//        let rnk = 1
//    }

}
