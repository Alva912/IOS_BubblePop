//
//  GameResultViewController.swift
//  BubblePop
//
//  Created by ljh on 22/1/21.
//

import UIKit

class GameResultViewController: UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var highScoreTabelView: UITableView!

    var playerName: String = "";
    var currentScore: Int = 0;

    var highScoreArray: [HighScore] = [];

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.setHidesBackButton(true, animated: false);

        // Retrive history data from local json file
        highScoreArray = readFromJSON();

        let newHighScore = HighScore(playerName: playerName, score: currentScore);
        var highestScore: Int = currentScore;
        var isExistingPlayer: Bool = false;

        for (index, highScore) in highScoreArray.enumerated() {
            if highScore.playerName == playerName {
                // Existing player
                isExistingPlayer = true;

                if currentScore < highScore.score {
                    // Current score is less than history high score
                    // Don't update high score
                    highestScore = highScore.score;
                } else {
                    // Updare new high score
                    highScoreArray.remove(at: index);
                    highScoreArray.append(newHighScore);
                }
            } else {
                // New player
            }
        }
        
        if !isExistingPlayer {
            highScoreArray.append(newHighScore);
        }
        
        saveToJSON(highScoreArray);
        
        // Displaay in UI
        playerNameLabel.text = playerName;
        scoreLabel.text = String(currentScore);
        highScoreLabel.text = String(highestScore);
    }
}

extension GameResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        highScoreArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrive cell from Prototype Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath);
        
        // Retrive index for corresponding data
        let index = indexPath.row;
        let highScore = highScoreArray[index];
        
        // Assign the data(content) to UI
        cell.textLabel?.text = highScore.playerName;
        cell.detailTextLabel?.text = String(highScore.score);
        
        return cell;
    }
}
