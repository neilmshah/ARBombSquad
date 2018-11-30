//
//  UserInfo.swift
//  ARBombSquad
//
//  Created by Neil Shah on 11/30/18.
//  Copyright © 2018 Neil. All rights reserved.
//

import Foundation
import Parse

class UserInfo: PFObject, PFSubclassing {
    
    @NSManaged var author: PFUser
    @NSManaged var score: String
    @NSManaged var level: Int
    
    static func parseClassName() -> String {
        return "UserInfo"
    }
    
    class func saveHighScore(score: String, level: Int, withCompletion completion: PFBooleanResultBlock?) {
        let userInfo = UserInfo()
        userInfo.author = PFUser.current()!
        userInfo.score = score
        userInfo.level = level
        
        userInfo.saveInBackground(block: completion)
    }

}
