//
//  GamePlayViewController.swift
//  BubblePop
//
//  Created by ljh on 12/1/21.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bubbleContainerView: UIView!
    
    var playerName: String = "";
    var remainTime: Int = 60;
    var numberLimit: Int = 0;
    
    var score: Int = 0;
    var timer = Timer();
    var bubbleArray: [UIButton] = [];
    
    var containerWidth: Int = 10;
    var containerHeight: Int = 10;
    var lastColor: UIColor = .white;
    
    let defaults = UserDefaults.standard;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Retrive data from UserDefaults
        if let playerName = defaults.string(forKey: PlayerNameKey) {
            self.playerName = playerName;
        }
        remainTime = defaults.integer(forKey: RemainTimeKey);
        numberLimit = defaults.integer(forKey: NumberLimitKey);
        
        // Display data onto UI
        playerNameLabel.text = "Player: \(playerName)";
        remainTimeLabel.text = "Timer: \(remainTime)";
        scoreLabel.text = "Score: \(score)";
        
        // A timer to count down and trigger functions every 1 sec
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.counter();
            self.generateBubble();
        }
        
    }
    
    // A method to update container size according to layout
    override func viewDidLayoutSubviews(){
        containerWidth = Int(self.bubbleContainerView.frame.size.width);
        containerHeight = Int(self.bubbleContainerView.frame.size.height);
    }
    
    // Stop timer when go to other screen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        if self.isMovingFromParent {
            timer.invalidate();
        }
    }
    
    @objc func counter() {
        remainTime -= 1;
        remainTimeLabel.text = "Timer: \(remainTime)";
        
        if remainTime == 0 {
            // Stop the timer
            timer.invalidate();
            print("Game is over!");
            
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
            // Needs more bubbles
            for _ in 1...bubbleNumber - bubbleArray.count {
                
                // A pos that is not overlap with exiting pos
                let bubblePos: BubblePos = generateBubblePos();
                
                let bubble = UIButton.bubbleButton(frame: CGRect(x: bubblePos.xAxis, y: bubblePos.yAxis, width: bubbleSize, height: bubbleSize));
                bubble.addTarget(self, action: #selector(bubblePressed(_:)), for: .touchUpInside);
                
                // Present in view
                self.bubbleContainerView.addSubview(bubble);
                bubbleArray.append(bubble);
            }

        } else if bubbleArray.count > bubbleNumber {
            // Remove bubbles randomly
            for _ in 1...bubbleArray.count - bubbleNumber {
                let removeIndex = Int.random(in: 0...bubbleArray.count - 1);
                
                // Remove from view
                bubbleArray[removeIndex].removeFromSuperview();
                bubbleArray.remove(at: removeIndex);
            }
            
        } else {
            print("Just enough bubbles! \(bubbleArray.count) = \(bubbleNumber)");
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
            
            scoreLabel.text = "Score: \(score)";
        } else {
            print("Bubble color unset");
        }
        
    }
    
    // Method to generate a unoverlapping bubble position (x,y)
    func generateBubblePos() -> BubblePos {
        var x: Int = 0;
        var y: Int  = 0;
        var isOverlap: Bool  = true; // while loop will be performed at least once
        
        while isOverlap {
            x = Int.random(in: 0...containerWidth-bubbleSize);
            y = Int.random(in: 0...containerHeight-bubbleSize);
            let frame = CGRect(x: x, y: y, width: bubbleSize, height: bubbleSize);
            isOverlap = false; // end the loop
            
            for bubble in bubbleArray {
                if bubble.frame.intersects(frame) {
                    isOverlap = true;
                }
            }
        }
        
        let bubblePos = BubblePos(xAxis: x, yAxis: y);
        return bubblePos;
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "gameOverSegue":
                print("Prepare segue for", identifier);
                
                if let vc = segue.destination as? GameResultViewController {
                    vc.playerName = playerName;
                    vc.currentScore = score;
                } else {
                    print("Type cast failed for segue", identifier);
                }
                break;
            default:
                print("Prepare segue for unhandled identifier", identifier);
            }
        } else {
            print("Segue with empty identifier is performed. Better check it.");
        }
    }
}
