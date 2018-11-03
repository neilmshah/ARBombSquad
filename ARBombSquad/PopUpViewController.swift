//
//  PopUpViewController.Swift
//  NMPopUpView
//
//  Created by Akshay on 10/02/16.
//  Copyright © 2016 Pi. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData

protocol PopupDelegate: class {
    func retryStage()
    func presentMainMenu()
    func nextStage()
}

@objc public class PopUpViewController : UIViewController, UITextViewDelegate {
    
    var noteObj:NSManagedObject!
    var startLocation:NSInteger = 0
    
    weak var delegate:PopupDelegate?
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!

    var type = InterstitialType.Pause

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.width)
        
        if type == .Failure {
            nextButton.isHidden = true
            statusLabel.text = "Failed to clear stage"
        }
        else if type == .Success {
            statusLabel.text = "Stage Cleared"
        }
        else {
            nextButton.isHidden = true
            statusLabel.text = "Stage Cleared"
        }
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.shadowOpacity = 0.8
        //        self.popUpView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
    }
    
    public func showInView(aView: UIView!, animated: Bool)
    {
        aView.addSubview(self.view)
        if animated
        {
            self.showAnimate()
        }
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    @IBAction func clickedNext(_ sender: Any) {
        delegate?.nextStage()
        removeAnimate()
    }
    
    
    @IBAction func clickedReplay(_ sender: Any) {
        delegate?.retryStage()
        removeAnimate()
    }
    
    @IBAction func pressedHome(_ sender: Any) {
        delegate?.presentMainMenu()
        removeAnimate()
    }
    
}
