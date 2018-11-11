//
//  StageTwo.swift
//  The Balloon Game
//
//  Created by Teamie on 2/10/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit
import SceneKit

class StageTwo: NSObject {

    var eggs : Array<SCNNode>? = []
    
    func configurationForStage() -> (Array<SCNNode>, Int, TimeInterval) { //eggs, tries, time
        for i in 0...2 {
            let eggScene = SCNScene(named: "Media.scnassets/tnt.scn")
            let eggNode = (eggScene?.rootNode.childNode(withName: "tnt", recursively: false))!
            eggNode.name = "egg"
            eggNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: eggNode, options: nil))
            eggNode.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
            eggNode.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
            let bombAnimation =  SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians),z:0, duration: 5)
            let foreverAction = SCNAction.repeatForever(bombAnimation)
            if i == 0 {
                eggNode.position = SCNVector3(x: 0, y: 20, z: -40)
                 eggNode.runAction(foreverAction)
            }
            else if i == 1 {
                eggNode.position = SCNVector3(x: -10, y: -5, z: -40)
                 eggNode.runAction(foreverAction)
            } else{
                eggNode.position = SCNVector3(x: 10, y: -5, z: -40)
                 eggNode.runAction(foreverAction)
            }
            eggs?.append(eggNode)
        }
        return (eggs!, 0, 0)
    }
    
}
