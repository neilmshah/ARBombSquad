//
//  Audio.swift
//  The Balloon Game
//
//  Created by Akshat Goel on 28/02/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import AVFoundation

class Audio {
    
    static var bgMusic: AVAudioPlayer?
    static var bgMusicVolume: Float = 0.12
    static var gunShot: AVAudioPlayer?
    static var balloonBurst: AVAudioPlayer?
    
    static func setVolumeLevel(to volume: Float) {
        
        if #available(iOS 10.0, *) {
            Audio.bgMusic?.setVolume(volume, fadeDuration: 1)
        } else {
            Audio.bgMusic?.volume = volume
        }
    }
}
