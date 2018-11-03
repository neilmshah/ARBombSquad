//
//  DataStore.swift
//  The Balloon Game
//
//  Created by Akshat Goel on 12/02/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import Foundation

class DataStore: NSObject, NSCoding {
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
    static let path = "\(DataStore.documentsDirectory)/DataStore.archive"
    
    var stageLevel: [String: [Int:Bool]] = [:]
    
    static var shared = DataStore()
    fileprivate override init() { }
    
    func encode(with archiver: NSCoder) {
        archiver.encode(stageLevel, forKey: "completedSets")
    }
    
    required init (coder unarchiver: NSCoder) {
        super.init()
        
        if let stageLevel = unarchiver.decodeObject(forKey: "completedSets") as? [String: [Int:Bool]] {
            self.stageLevel = stageLevel
        }
    }
    
    func save() -> Bool {
        return NSKeyedArchiver.archiveRootObject(self, toFile: DataStore.path)
    }

}
