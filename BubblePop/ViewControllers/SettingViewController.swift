//
//  SettingViewController.swift
//  BubblePop
//
//  Created by ljh on 17/1/21.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "\(Int(timeSlider.value))";
        numberLabel.text = "\(Int(numberSlider.value))";
    }
    
    @IBAction func startButtonOnClick(_ sender: Any) {
        if let name = nameTextField.text {
            if name.count > 0 {
                // Store data to userDefaults
                let defaults = UserDefaults.standard;
                defaults.set(name, forKey: "PlayerName");
                
                let remainTime = timeSlider.value;
                defaults.set(remainTime, forKey: "RemainTime");
                
                let numberLimit = numberSlider.value;
                defaults.set(numberLimit, forKey: "NumberLimit");
                
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
    
    @IBAction func timeSliderValueChanged(_ sender: UISlider) {
        var currentValue = Int(sender.value);
        timeLabel.text = "\(currentValue)";
    }
    
    @IBAction func numberSliderValueChanged(_ sender: UISlider) {
        var currentValue = Int(sender.value);
        numberLabel.text = "\(currentValue)";
    }
}
