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

    let defaults = UserDefaults.standard;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrive previous settings
//        let playerName = defaults.string(forKey: PlayerNameKey);
        let remainTime = defaults.integer(forKey: RemainTimeKey);
        let numberLimit = defaults.integer(forKey: NumberLimitKey);
        
        // Set up slider current value
        timeSlider.value = Float(remainTime);
        numberSlider.value = Float(numberLimit);

        // Display in UI
//        nameTextField.text = playerName;
        timeLabel.text = "\(remainTime)";
        numberLabel.text = "\(numberLimit)";
    }
    
    @IBAction func startButtonOnClick(_ sender: Any) {
        
        let alert = UIAlertController(title: "Error:", message: "Please enter your name", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in self.nameTextField.becomeFirstResponder()}));
        
        if let playerName = nameTextField.text {
            if playerName.count > 0 {
                // Store data to userDefaults
                defaults.set(playerName, forKey: PlayerNameKey);
                
                let remainTime = timeSlider.value;
                defaults.set(remainTime, forKey: RemainTimeKey);
                
                let numberLimit = numberSlider.value;
                defaults.set(numberLimit, forKey: NumberLimitKey);
                
                // Trigger segue
                print("Trigger segue for", playerName);
                self.performSegue(withIdentifier: "startGameSegue", sender: nil);
            } else {
                self.present(alert, animated: true);
            }
        } else {
            self.present(alert, animated: true);
        }
    }
    
    @IBAction func timeSliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value);
        timeLabel.text = "\(currentValue)";
    }
    
    @IBAction func numberSliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value);
        numberLabel.text = "\(currentValue)";
    }
}
