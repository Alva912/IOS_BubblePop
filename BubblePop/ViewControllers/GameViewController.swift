//
//  GameViewController.swift
//  BubblePop
//
//  Created by ljh on 12/1/21.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainTimeLabel: UILabel!
    
    
    var name:String = "";
    var timer = Timer();
    var remainTime = 60;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard;
        name = defaults.string(forKey: "PlayerName") ?? "Default Name";
        remainTime = defaults.integer(forKey: "RemainTime");
        
        nameLabel.text = name;
        remainTimeLabel.text = String(remainTime);
    }

}
