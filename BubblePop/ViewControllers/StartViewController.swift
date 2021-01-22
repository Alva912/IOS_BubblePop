//
//  StartViewController.swift
//  BubblePop
//
//  Created by ljh on 17/1/21.
//

import UIKit

class StartViewController: UIViewController {

    let defaults = UserDefaults.standard;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Init default game settings
        if defaults.integer(forKey: RemainTimeKey) == 0 {
            defaults.set(30, forKey: RemainTimeKey);
        }
        if defaults.integer(forKey: NumberLimitKey) == 0 {
            defaults.set(15, forKey: NumberLimitKey);
        }
        if defaults.dictionary(forKey: HighScoreDictKey) == nil {
            let highScoreDict: [String: Int] = [:];
            defaults.set(highScoreDict, forKey: HighScoreDictKey);
        }    }
    
    // MARK: - Navigation

    @IBAction func unwindToStartView(segue: UIStoryboardSegue) {
//        defaults.set("", forKey: PlayerNameKey);
    }

}
