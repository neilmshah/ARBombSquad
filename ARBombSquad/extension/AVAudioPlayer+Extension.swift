//
//  AVAudioPlayer+Extension.swift
//  The Balloon Game
//
//  Created by Akshat Goel on 28/02/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import AVFoundation

extension AVAudioPlayer {
    
    convenience init?(file: String, type: String) {
        
        guard let path = Bundle.main.path(forResource: file, ofType: type) else { print("Incorrect audio path"); return nil }
        let url = URL(fileURLWithPath: path)
        
        try? self.init(contentsOf: url)
    }
}
