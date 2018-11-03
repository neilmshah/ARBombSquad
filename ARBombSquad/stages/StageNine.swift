//
//  StageNine.swift
//  The Balloon Game
//
//  Created by Akshat Goel on 12/02/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit
import SceneKit
class StageNine: NSObject {
    
    var eggs : Array<SCNNode>? = []
    
    func configurationForStage() -> (Array<SCNNode>, Int, TimeInterval) {   //eggs, tries, time
        for i in 0...2 {
            let eggScene = SCNScene(named: "Media.scnassets/egg.scn")
            let eggNode = (eggScene?.rootNode.childNode(withName: "egg", recursively: false))!
            eggNode.name = "egg"
            eggNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: eggNode, options: nil))
            eggNode.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
            eggNode.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
            if i == 0 {
                eggNode.position = SCNVector3(x: -20, y: 5, z: -40)
            }
            else if i == 1{
                eggNode.position = SCNVector3(x: 0, y: 5, z: -40)
            }
            else if i == 2{
                eggNode.position = SCNVector3(x: 20, y: 5, z: -40)
            }
            eggs?.append(eggNode)
        }
        return (eggs!, 3, 20)
    }


}
