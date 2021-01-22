//
//  GameResultViewController.swift
//  BubblePop
//
//  Created by ljh on 22/1/21.
//

import UIKit

class GameResultViewController: UIViewController {
    
    var playerName: String = "";
    var score: Int = 0;    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.setHidesBackButton(true, animated: false);
    }

}
