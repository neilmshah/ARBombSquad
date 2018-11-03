//
//  ViewController.swift
//  Planets
//
//  Created by Akshat Goel on 02/11/17.
//  Copyright © 2017 starksky. All rights reserved.
//

import UIKit
import ARKit
import MZTimerLabel
import AVFoundation
import SceneKit
import STZPopupView

enum BitMaskCategory: Int {
    case bullet = 2
    case target = 3
    case obstacle = 4
}

class GamePlayViewController: UIViewController, SCNPhysicsContactDelegate, ARSCNViewDelegate, MZTimerLabelDelegate, InterstitialDelegate {
    
    @IBOutlet weak var gunSceneView: SCNView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var noFBalloonsLabel: UILabel!
    @IBOutlet weak var noFBulletsLabel: UILabel!
    var currentPositionOfCamera:SCNVector3!
    let configuration = ARWorldTrackingConfiguration()
    var power: Float = 40
    var Target: SCNNode?
    var targetBullet: SCNNode?
    var stage : Int!
    var score : Int!
    var gunShotPlayer : AVAudioPlayer?
    var balloonBurstPlayer : AVAudioPlayer?
    var balloonCount = 0
    var fireCount : Int?
    var gunCameraNode : SCNNode!
    var gunScene:SCNScene!
    var cameraNode:SCNNode!
    var gunShotNode:SCNNode!
    let popViewController : PopUpViewController = PopUpViewController(nibName: "PopUpViewController", bundle: nil)
    var popup : KLCPopup!
    var interstitialVC : StageInterstitialViewController?
    
    @IBOutlet weak var timerLabel: MZTimerLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.sceneView.addGestureRecognizer(gestureRecognizer)
        self.sceneView.scene.physicsWorld.contactDelegate = self
        self.sceneView.delegate  = self
        
        timerLabel.timerType = MZTimerLabelTypeTimer
        timerLabel.timeFormat = "ss SS"
        timerLabel.delegate = self
                
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let pointofView = sceneView.pointOfView else {return}
        let transform = pointofView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        // how your phone is located is related to scene
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        currentPositionOfCamera = orientation + location
        
        initializeSounds()
        
        initializeGunSceneView()
        initializeGunScene()
        initializeGunCamera()
        addGun()
    }
    
    func  initializeGunSceneView(){
        gunSceneView.backgroundColor = UIColor.clear
        gunSceneView.allowsCameraControl = true
        gunSceneView.autoenablesDefaultLighting = true
        gunSceneView.delegate = self
        gunSceneView.isUserInteractionEnabled = false
    }
    
    func initializeGunCamera(){
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: -0.9, y: 1.1, z: 0.6)
        cameraNode.eulerAngles = SCNVector3(0,-30.degreesToRadians,0)
        gunScene.rootNode.addChildNode(cameraNode)
        
    }
    
    func initializeGunScene(){
        gunScene = SCNScene()
        gunSceneView.scene = gunScene
        gunSceneView.isPlaying = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        guard let sceneView = sender.view as? ARSCNView else {return}
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let position = orientation + location
        let bullet = SCNNode(geometry: SCNSphere(radius: 0.02))
        // let bulletScene = SCNScene(named: "Media.scnassets/bulletScene.scn")
        // let bullet = bulletScene?.rootNode.childNode(withName: "bulletscene", recursively: false)
        playGunShotSound()
        bullet.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        bullet.position = position
        let body = SCNPhysicsBody(type: .dynamic, shape: nil)
        body.isAffectedByGravity = false
        
        body.applyForce(SCNVector3(orientation.x*power, orientation.y*power, orientation.z*power), asImpulse: true)
        body.categoryBitMask = BitMaskCategory.bullet.rawValue
        body.contactTestBitMask = BitMaskCategory.target.rawValue
        bullet.physicsBody = body
        self.sceneView.scene.rootNode.addChildNode(bullet)
        if(fireCount != 0){
            fireCount = fireCount! -  1
        }
        noFBulletsLabel.text = String(fireCount!)
        bullet.runAction(
            SCNAction.sequence([SCNAction.wait(duration: 2.0),
                                SCNAction.removeFromParentNode()])
        )
        gunAnimate()
        
        if(fireCount == 0){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                if(self.fireCount == 0 && self.balloonCount > 0){
                    self.presentInterstitialWith(type: .Failure)
                }
            }
        }
        
        
    }
    
    func playGunShotSound() {
        gunShotPlayer = preparePlayerForSound(named: "gunshot")
        gunShotPlayer?.prepareToPlay()
        gunShotPlayer?.play()
    }
    
    func playBalloonBurstSound() {
        balloonBurstPlayer = preparePlayerForSound(named : "balloonburst")
        balloonBurstPlayer?.prepareToPlay()
        balloonBurstPlayer?.play()
    }
    
    
    
    func preparePlayerForSound(named sound: String) -> AVAudioPlayer? {
        do {
            if let soundPath = Bundle.main.path(forResource: sound, ofType: "wav") {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
                try AVAudioSession.sharedInstance().setActive(true)
                return try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: soundPath) as URL)
            } else {
                print("The file '\(sound).mp3' is not available")
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    @IBAction func addTargets(_ sender: Any) {
        self.configureViewForStage(configureStage: stage)
        print("add targets ", stage)
    }
    
    private func initializeSounds(){
        
        Audio.balloonBurst = AVAudioPlayer(file: "balloonburst", type: "wav")
        Audio.gunShot = AVAudioPlayer(file: "gunshot", type: "wav")
    }
    
    func addEgg(x: Float, y: Float, z: Float) {
        let eggScene = SCNScene(named: "Media.scnassets/egg.scn")
        let eggNode = (eggScene?.rootNode.childNode(withName: "egg", recursively: false))!
        eggNode.position =    SCNVector3(x,y,z)
        eggNode.name = "egg"
        eggNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: eggNode, options: nil))
        eggNode.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
        eggNode.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
        self.sceneView.scene.rootNode.addChildNode(eggNode)
        
    }
    
    func addGun(){
        let gunScene = SCNScene(named: "Media.scnassets/shtgun.scn")
        
        gunCameraNode = (gunScene?.rootNode.childNode(withName: "shotgun", recursively: false))
        gunShotNode = (gunCameraNode.childNode(withName: "guntip", recursively: false))
        gunCameraNode.position = SCNVector3(0,0,0)
        gunCameraNode.scale = SCNVector3(5,5,5)
        gunShotNode.position = SCNVector3(2,5,-6.5)
        //  let shotgunNode = (gunScene?.rootNode.childNode(withName: "shotgun", recursively: false))
        gunCameraNode.eulerAngles = SCNVector3(50.degreesToRadians,0,0)
        
        // gunCameraNode?.position = SCNVector3Make(0,0,0)
        //   cameraNode?.didUpdateFocus(in: <#T##UIFocusUpdateContext#>, with: <#T##UIFocusAnimationCoordinator#>)
        //    self.sceneView.scene.rootNode.addChildNode(gunCameraNode!)
        gunScene?.rootNode.addChildNode(gunCameraNode)
        
        gunSceneView.scene?.rootNode.addChildNode(gunCameraNode)
        
    }
    
    func gunAnimate(){
        
        let rotActionUp = SCNAction.rotateBy(x: CGFloat(5.degreesToRadians), y: 0, z: 0, duration: 0.1)
        let rotActionDown = SCNAction.rotateBy(x: CGFloat(-5.degreesToRadians), y: 0, z: 0, duration: 0.1)
        let gunMoveSequence = SCNAction.sequence([rotActionUp,rotActionDown])
        gunCameraNode.runAction(gunMoveSequence)
        
        //particle system
        let gunFireParcticleSystem = SCNParticleSystem(named: "Media.scnassets/fireShot.scnp", inDirectory: nil)
        
        gunFireParcticleSystem?.loops = false
        gunFireParcticleSystem?.particleLifeSpan = 0.2
        
        //let particleNode = gunCameraNode.childNode(withName: "guntip", recursively: false)
        print(gunShotNode?.position.x, gunShotNode?.position.y, gunShotNode?.position.z)
        
        gunShotNode?.addParticleSystem(gunFireParcticleSystem!)
        gunSceneView.scene?.rootNode.addChildNode(gunShotNode!)
        
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        //        guard let pointOfView = renderer.pointOfView else {return}
        //        let transform = pointOfView.transform
        //        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        //        let location = SCNVector3(-transform.m41, transform.m42, transform.m43+0.9)
        //        print(orientation.x, orientation.y, orientation.z)
        //   //     gunCameraNode.eulerAngles = SCNVector3(0, 0, 0)
        //        gunCameraNode.position = location + orientation
        
        
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        print("Collision detected")
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        print("contact - ", contact)
        print("bitmask category - ",BitMaskCategory.target.rawValue)
        if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.Target = nodeA
            self.targetBullet = nodeB
        } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.Target = nodeB
            self.targetBullet = nodeA
        }
        print("ballooncount  - ",self.balloonCount)
        self.balloonCount = self.balloonCount - 1
        
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.noFBalloonsLabel.text = String(self.balloonCount)
        }
        
        let confetti = SCNParticleSystem(named: "Media.scnassets/Confetti.scnp", inDirectory: nil)
        confetti?.loops = false
        confetti?.particleLifeSpan = 2
        confetti?.emitterShape = Target?.geometry
        let confettiNode = SCNNode()
        confettiNode.addParticleSystem(confetti!)
        confettiNode.position = contact.contactPoint
        self.sceneView.scene.rootNode.addChildNode(confettiNode)
        playBalloonBurstSound()
        
        Target?.removeFromParentNode()
        //  targetBullet?.removeFromParentNode()
        var isEggsFinished:Bool = true
        sceneView.scene.rootNode.enumerateChildNodes{(node, _) in
            if node.name  == "egg" {
                isEggsFinished = false
            }
        }
        if isEggsFinished{
            print("stage finished ")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                //   self.stageTwo()
                self.presentInterstitialWith(type: .Success)
            }
        } else {
            print("game still going on")
        }
    }
    
    // MARK: - Interstitial

    func presentInterstitialWith(type : InterstitialType) {
        
        interstitialVC = storyboard?.instantiateViewController(withIdentifier: "StageInterstitialViewController") as? StageInterstitialViewController
        interstitialVC?.delegate = self
        interstitialVC?.type = type
        interstitialVC?.view.frame = CGRect(x: 50, y: 150, width: UIScreen.main.bounds.size.width - 100, height: UIScreen.main.bounds.size.height - 300)
        
        popup = KLCPopup.init(contentView: interstitialVC?.view, showType: .growIn, dismissType: .growOut, maskType: .dimmed, dismissOnBackgroundTouch: false, dismissOnContentTouch: false)
        popup.show()
    }
    
    //to check whether the stage finished in time or not and then accordingly determine success or failure
    func  stageFinishCheck(){
        
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval) {


    }
    
    func  stageFinishSuccess(){
        UserDefaultsManager.stage = stage+1
        print("success- ",stage+1)
        guard DataStore.shared.save() else { print("Error saving settings"); return }
        stageController(success: true)
    }
    
    func stageFinishFailure(){
        UserDefaultsManager.stage = stage
        self.presentInterstitialWith(type: .Failure)
    }
    
    func  stageController(success:Bool) {
        if success {
            configureViewForStage(configureStage: stage + 1)
        } else {
            configureViewForStage(configureStage: stage)
        }
    }
    
    func configureViewForStage(configureStage : Int){
        stage = configureStage
        let configuration = StageConfiguration()
        configuration.configureForStage(stage: configureStage)
        var eggCount = 0
        print("Number of tries - \(configuration.numberOfTries) and time - \(configuration.time)")
        for egg in configuration.eggs {
            eggCount += 1
            self.sceneView.scene.rootNode.addChildNode(egg)
        }
        fireCount = configuration.numberOfTries
        self.balloonCount = eggCount
        print("ballooncount -- ",self.balloonCount)
        self.noFBalloonsLabel.text = String(self.balloonCount)
        for obstacle in configuration.obstacles {
            self.sceneView.scene.rootNode.addChildNode(obstacle)
        }
        
        noFBulletsLabel.text =   String(fireCount!)
        noFBalloonsLabel.text = String(balloonCount)
        if configuration.time != 0 {
            timerLabel.isHidden = false
            timerLabel.setCountDownTime(configuration.time)
            timerLabel.start()
        }
        else {
            timerLabel.isHidden = true
        }
    }
    
    @IBAction func pauseClicked(_ sender: Any) {
        self.presentInterstitialWith(type: .Pause)
    }
    
    func retryStage() {
        popup.dismiss(true)
        stageController(success: false)
    }
    
    func presentMainMenu() {
        popup.dismiss(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func nextStage() {
        popup.dismiss(true)
        stageController(success: true)
    }
    
    func closePopup() {
        popup.dismiss(true)
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
