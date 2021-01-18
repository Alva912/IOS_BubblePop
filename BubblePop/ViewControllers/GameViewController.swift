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
    
    var name: String = "";
    var remainTime: Int = 60;
    var numberLimit: Int = 0;
    
    var score: Int = 0;
    var timer = Timer();
    var bubbleArray: [UIButton] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrive data from UserDefaults
        let defaults = UserDefaults.standard;
        name = defaults.string(forKey: "PlayerName") ?? "Hello";
        remainTime = defaults.integer(forKey: "RemainTime");
        numberLimit = defaults.integer(forKey: "NumberLimit");

        // Display data to UI
        nameLabel.text = name;
        remainTimeLabel.text = String(remainTime);
        scoreLabel.text = String(score);
        
        // A timer dount down every 1 sec and call functions
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.counter();
            self.generateBubble();
        }
    }
    
    @objc func counter() {
        remainTime -= 1;
        remainTimeLabel.text = String(remainTime);
        
        if remainTime == 0 {
            // Stop the timer
            timer.invalidate();
            print("Game is over!");
            // Go to next screen
            self.performSegue(withIdentifier: "gameOverSegue", sender: nil);
        } else {
            print("The timer is counting down!");
        }
    }
    
    @objc func generateBubble() {
        
        // Random number of bubbles up to the limit
        let bubbleNumber = Int.random(in: 5...numberLimit);
        
        if bubbleArray.count < bubbleNumber {
            
            print("Too little bubbles! \(bubbleArray.count) < \(bubbleNumber)")
            
            for i in 1...bubbleNumber - bubbleArray.count {
                print(i);
                let xAxis = Int.random(in: 50...300);
                let yAxis = Int.random(in: 50...300);
                let bubble = UIButton.bubbleButton(frame: CGRect(x: xAxis, y: yAxis, width: 50, height: 50));
                bubble.addTarget(self, action: #selector(bubblePressed(_:)), for: .touchUpInside);
                
                self.view.addSubview(bubble);
                bubbleArray.append(bubble);
            }
            
        } else if bubbleArray.count > bubbleNumber {
            
            print("Too many bubbles! \(bubbleArray.count) > \(bubbleNumber)")
            
            for i in 1...bubbleArray.count - bubbleNumber {
                print(i)
                let removeIndex = Int.random(in: 0...bubbleArray.count - 1);
                bubbleArray[removeIndex].removeFromSuperview();
                bubbleArray.remove(at: removeIndex);
            }
            
        } else {
            print("There's enough bubbles! \(bubbleArray.count) = \(bubbleNumber)")
        }
        
    }
    
    @IBAction func bubblePressed(_ sender: UIButton) {
        sender.removeFromSuperview();
        
        // update the player's score
        score += 1;
        scoreLabel.text = String(score);
        
        print("This bubble is pressed");
    }
    
}
