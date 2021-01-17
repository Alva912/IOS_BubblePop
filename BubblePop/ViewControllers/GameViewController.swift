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
    @IBOutlet weak var scoreLabel: UILabel!
    
    var name:String = "";
    var timer = Timer();
    var remainTime = 60;
    var score = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard;
        name = defaults.string(forKey: "PlayerName") ?? "Default Name";
        remainTime = defaults.integer(forKey: "RemainTime");
        
        nameLabel.text = name;
        remainTimeLabel.text = String(remainTime);
        
        scoreLabel.text = String(score);
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.counter();
            self.generateBubble();
            //self.removeBubble()
        }
    }
    
    @objc func counter() {
        remainTime -= 1;
        remainTimeLabel.text = String(remainTime);
        
        if remainTime == 0 {
            timer.invalidate();
            print("Game is over!");
            
            self.performSegue(withIdentifier: "gameOverSegue", sender: nil);
        } else {
            print("The timer is counting down!");
        }
    }
    
    @objc func generateBubble() {
        // TODO - create bubble class
        let bubble = UIButton();
        let xAxis = Int.random(in: 20...200);
        let yAxis = Int.random(in: 20...200);
        bubble.frame = CGRect(x: xAxis, y: yAxis, width: 50, height: 50);
        bubble.layer.cornerRadius = 0.5 * bubble.bounds.size.width;
        bubble.backgroundColor = .red;
        bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside);
        self.view.addSubview(bubble);
        
    }
    
    @IBAction func bubblePressed(_ sender: UIButton) {
        sender.removeFromSuperview();
        
        // update the player's score
        score += 1;
        scoreLabel.text = String(score);
        
        print("This bubble is pressed");
    }
    
}
