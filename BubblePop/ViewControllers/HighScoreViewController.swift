//
//  HighScoreViewController.swift
//  BubblePop
//
//  Created by ljh on 12/1/21.
//

import UIKit

struct HighScore: Codable {
    var playerName: String;
    var score: Int;
}

class HighScoreViewController: UIViewController {
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    // Retrive history data from json file directly
    // or use readFromJSON();
    var highScoreArray: [HighScore] = anotherReadFromJSON();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrive current data from defaults
        let defaults = UserDefaults.standard;
        if let currentName = defaults.string(forKey: PlayerNameKey){
            let currentHighScore = HighScore(playerName: currentName, score: defaults.integer(forKey: "Score"));
            highScoreArray.append(currentHighScore);
            anotherSaveToJSON(highScoreArray);
            
            // Empty the User Defaults - including previous game settings
//            defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:));
        } else {
            print("No new game data");
        }
        
    }
    
}

// DataSource - for Table View to display data
extension HighScoreViewController: UITableViewDataSource {
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

// Delegate - for Tabe View to peform actions
extension HighScoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Retrive cell
        let cell = tableView.cellForRow(at: indexPath);
        
        // Retrive index for corresponding data
        let index = indexPath.row;
        let highScore = highScoreArray[index];
        
        print("Selectd row: \(cell?.textLabel?.text)");
        print("Selectd row: \(highScore)");
        
        // When cell selected, delete the data
        highScoreArray.remove(at: index);
        // tableView.reloadData();
        tableView.deleteRows(at: [indexPath], with: .fade);
        
    }
}
