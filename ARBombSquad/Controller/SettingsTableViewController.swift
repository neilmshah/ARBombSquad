//
//  SettingsTableViewController.swift
//  ARBombSquad
//
//  Created by Neil Shah on 11/29/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var muteSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let mute = defaults.bool(forKey: "muteVolume")
        let volume = defaults.float(forKey: "volumeValue")
        
        volumeSlider.value = volume
        muteSwitch.isOn=mute
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            
        case 1:
            switch indexPath.row {
            case 0:
                self.resetProgressAlert(indexPath: indexPath)
                //UIFeedbackGenerator.notificationOcurredOf(type: .warning)
            default: break
            }
        default: break
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        let defaults = UserDefaults.standard
        defaults.set(sender.value, forKey: "volumeValue")
        defaults.synchronize()
    }
    
    @IBAction func muteTapped(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        defaults.set(sender.isOn, forKey: "muteVolume")
        defaults.synchronize()
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogOut"), object: nil)
    }
    
    private func resetProgressAlert(indexPath: IndexPath) {
        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .alert)
        
        alertViewController.modalPresentationStyle = .popover
        
        alertViewController.addAction(title: "Cancel".localized, style: .cancel)
        alertViewController.addAction(title: "Everything".localized, style: .destructive) { action in
            //self.resetProgressOptions()
        }
        alertViewController.addAction(title: "Only Statistics".localized, style: .default) { action in
            //self.resetProgressStatistics()
        }
        
        self.present(alertViewController, animated: true)
    }
}

