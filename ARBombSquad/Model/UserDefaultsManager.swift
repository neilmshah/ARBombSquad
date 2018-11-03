//
//  UserDefaultsManager.swift
//  The Balloon Game
//
//  Created by Akshat Goel on 06/01/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import Foundation

class UserDefaultsManager{
    
    private static let defaults = UserDefaults.standard
    
    enum itemsToSave: String{
        case stage
        case score
        
        fileprivate static var trueByDefaultSwitches: [itemsToSave] {
            return [.stage]
        }
    }
    
    static func loadDefaultValues() {
        
        for switchItem in itemsToSave.trueByDefaultSwitches where defaults.object(forKey: switchItem.rawValue) == nil {
            defaults.set(true, forKey: switchItem.rawValue)
        }
        
        let userStageLevel = itemsToSave.stage.rawValue
        if defaults.object(forKey: userStageLevel) == nil {
            UserDefaultsManager.stage = 0
        }
        
        let score = itemsToSave.score.rawValue
        if defaults.object(forKey: score) == nil {
            UserDefaultsManager.score = 0
        }
    }
    
    static var stage: Int {
        get { return defaults.integer(forKey: itemsToSave.stage.rawValue) }
        set { defaults.set(newValue, forKey: itemsToSave.stage.rawValue) }
    }
    
    static var score: Int {
        get { return defaults.integer(forKey: itemsToSave.score.rawValue) }
        set { defaults.set(newValue, forKey: itemsToSave.score.rawValue) }
    }
}
