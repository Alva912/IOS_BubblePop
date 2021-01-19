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
    @IBOutlet weak var bubbleContainerView: UIView!
    
    var name: String = "";
    var remainTime: Int = 60;
    var numberLimit: Int = 0;
    
    var score: Int = 0;
    var timer = Timer();
    var bubbleArray: [UIButton] = [];
    
    let bubbleSize: Int = 75;
    var containerWidth: Int = 10;
    var containerHeight: Int = 10;
    var lastColor: UIColor = .white;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrive data from UserDefaults
        let defaults = UserDefaults.standard;
        if let name = defaults.string(forKey: "PlayerName") {
            self.name = name;
        }
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
    
    override func viewDidLayoutSubviews(){
        containerWidth = Int(self.bubbleContainerView.frame.size.width);
        containerHeight = Int(self.bubbleContainerView.frame.size.height);
    }
    
    @objc func counter() {
        remainTime -= 1;
        remainTimeLabel.text = String(remainTime);
        
        if remainTime == 0 {
            // Stop the timer
            timer.invalidate();
            print("Game is over!");
            
            // Pass data
            let defaults = UserDefaults.standard;
            defaults.set(score, forKey: "Score");
            
            // Go to next screen
            self.performSegue(withIdentifier: "gameOverSegue", sender: nil);
        } else {
            print("The timer is counting down! bubbleArray: \(bubbleArray.count)");
        }
    }
    
    @objc func generateBubble() {
        
        // Random number of bubbles up to the limit
        let bubbleNumber = Int.random(in: 0...numberLimit);
        
        if bubbleArray.count < bubbleNumber {
            
            for _ in 1...bubbleNumber - bubbleArray.count {
                let xAxis = Int.random(in: 0...containerWidth-bubbleSize);
                let yAxis = Int.random(in: 0...containerHeight-bubbleSize);
                let bubble = UIButton.bubbleButton(frame: CGRect(x: xAxis, y: yAxis, width: bubbleSize, height: bubbleSize));
                bubble.addTarget(self, action: #selector(bubblePressed(_:)), for: .touchUpInside);
                self.bubbleContainerView.addSubview(bubble);
                bubbleArray.append(bubble);
            }
            
        } else if bubbleArray.count > bubbleNumber {
            
            for _ in 1...bubbleArray.count - bubbleNumber {
                let removeIndex = Int.random(in: 0...bubbleArray.count - 1);
                bubbleArray[removeIndex].removeFromSuperview();
                bubbleArray.remove(at: removeIndex);
            }
            
        } else {
            print("Just enough bubbles! \(bubbleArray.count) = \(bubbleNumber)")
        }
        
    }
    
    @IBAction func bubblePressed(_ sender: UIButton) {
        if let index = bubbleArray.firstIndex(of: sender){
            bubbleArray.remove(at: index);
            print("bubbleArray: \(bubbleArray.count)");
        }
        
        sender.removeFromSuperview();
        
        // update the player's score
        if let color = sender.backgroundColor{
            var scoreBoost: Float;
            
            if color == lastColor {
                scoreBoost = 1.5;
            } else {
                scoreBoost = 1.0;
            }
            
            switch color {
            case .black:
                score += Int(10 * scoreBoost);
            case .blue:
                score += Int(8 * scoreBoost);
            case .green:
                score += Int(5 * scoreBoost);
            case .systemPink:
                score += Int(2 * scoreBoost);
            default:
                score += Int(1 * scoreBoost);
            }
            
            lastColor = color;
            
            scoreLabel.text = String(score);
        } else {
            print("Bubble color unset")
        }
        
    }
    
}
