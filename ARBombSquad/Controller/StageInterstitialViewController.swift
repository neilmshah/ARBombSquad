//
//  StageInterstitialViewController.swift
//  The Balloon Game
//
//  Created by Teamie on 3/1/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit

protocol InterstitialDelegate: class {
    func retryStage()
    func presentMainMenu()
    func nextStage()
    func closePopup()
}

enum InterstitialType {
    case Success
    case Failure
    case Pause
}

class StageInterstitialViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    weak var delegate: InterstitialDelegate?
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var type = InterstitialType.Pause
    
    var closeHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: 300,height: 600)

        if type == .Failure {
            nextButton.isHidden = true
            statusLabel.text = "Failed to clear stage"
        }
        else if type == .Success {
            statusLabel.text = "Stage Cleared"
        }
        else if type == .Pause {
            nextButton.isHidden = true
            cancelButton.isHidden = false
            statusLabel.text = "Paused"
        }
        else {
            nextButton.isHidden = true
            statusLabel.text = "Stage Cleared"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func instance() -> StageInterstitialViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "StageInterstitialViewController") as! StageInterstitialViewController
    }
    
    @IBAction func clickedNext(_ sender: Any) {
        delegate?.nextStage()
    }
    
    
    @IBAction func clickedReplay(_ sender: Any) {
        delegate?.retryStage()
    }
    
    @IBAction func pressedHome(_ sender: Any) {
        delegate?.presentMainMenu()
    }
    
    @IBAction func pressedCancel(_ sender: Any) {
        delegate?.closePopup()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
