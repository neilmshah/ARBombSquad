//
//  StageConfiguration.swift
//  The Balloon Game
//
//  Created by starksky on 2/10/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit
import SceneKit

class StageConfiguration: NSObject {
    
    var eggs : Array<SCNNode> = []
    var numberOfTries : Int = 0
    var obstacles : Array<SCNNode> = []
    var time : TimeInterval = 0
    
    func configureForStage(stage : Int) {
        if stage == 1 {
            let stage = StageOne()
            (eggs, numberOfTries, time) = stage.configurationForStage()
        }
        else if stage == 2 {
            let stage = StageTwo()
            (eggs, numberOfTries, time) = stage.configurationForStage()
        }
        
        else if stage == 3 {
            let stage = StageThree()
            (eggs, numberOfTries, time) = stage.configurationForStage()
        }

        else if stage == 4 {
            let stage = StageFour()
            (eggs, numberOfTries, time) = stage.configurationForStage()
        }

        else if stage == 5 {
            let stage = StageFive()
            (eggs, numberOfTries, time) = stage.configurationForStage()
        }

        else if stage == 6 {
            let stage = StageSix()
            (eggs, numberOfTries, time)  = stage.configurationForStage()
        }


        else if stage == 7 {
            let stage = StageSeven()
            (eggs, numberOfTries, time)  = stage.configurationForStage()
        }

        else if stage == 8 {
            let stage = StageEight()
           (eggs, numberOfTries, time)  = stage.configurationForStage()
        }

        else if stage == 9 {
            let stage = StageNine()
           (eggs, numberOfTries, time) = stage.configurationForStage()
        }

        else if stage == 10 {
            let stage = StageTen()
            (eggs, numberOfTries, time)  = stage.configurationForStage()
        }
    }
    
}
