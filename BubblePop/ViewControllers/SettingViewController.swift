//
//  SettingViewController.swift
//  BubblePop
//
//  Created by ljh on 17/1/21.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var numberSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonOnClick(_ sender: Any) {
        if let name = nameTextField.text {
            if name.count > 0 {
                // Store data to userDefaults
                let defaults = UserDefaults.standard;
                defaults.set(name, forKey: "PlayerName");
                
                let remainTime = timeSlider.value;
                defaults.set(remainTime, forKey: "RemainTime");
                
                // Trigger segue
                print("Trigger segue for", name);
                self.performSegue(withIdentifier: "startGameSegue", sender: nil);
            } else {
                // Show alert (TODO)
                print("Please enter a non-empty name");
            }
        } else {
            // Show alert (TODO)
            print("Please enter a name");
        }
    }
    
}
