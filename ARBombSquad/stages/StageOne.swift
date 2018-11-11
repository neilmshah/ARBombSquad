//
//  StageOne.swift
//  The Balloon Game
//
//  Created by Akshat Goel on 06/01/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit
import SceneKit

class StageOne: NSObject {
    
    var eggs : Array<SCNNode>? = []
    
    func configurationForStage() -> (Array<SCNNode>, Int, TimeInterval) {  //eggs, tries, time
        
        let eggScene = SCNScene(named: "Media.scnassets/tnt.scn")
        let eggNode = (eggScene?.rootNode.childNode(withName: "tnt", recursively: false))!
        eggNode.name = "egg"
        eggNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: eggNode, options: nil))
        eggNode.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
        eggNode.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
        
        eggNode.position = SCNVector3(x: 0, y: 0, z: -40)
        let bombAnimation =  SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians),z:0, duration: 5)
        let foreverAction = SCNAction.repeatForever(bombAnimation)
        eggNode.runAction(foreverAction)
        eggs?.append(eggNode)
        return (eggs!, 0, 0)
    }
}
