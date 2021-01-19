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
    var highScoreArray: [HighScore] = {
        do {
            guard let filePath = Bundle.main.path(forResource: "highScore", ofType: "json") else { return [] }
            let localData = NSData.init(contentsOfFile: filePath)! as Data;
            
            let decoder = JSONDecoder();
            let highScores = try decoder.decode([HighScore].self, from: localData);
            
            return highScores;
        } catch {
            print(error.localizedDescription);
            return [];
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrive current data from defaults
        let defaults = UserDefaults.standard;
        if let currentName = defaults.string(forKey: "PlayerName"){
            let currentHighScore = HighScore(playerName: currentName, score: defaults.integer(forKey: "Score"));
            highScoreArray.append(currentHighScore);
            saveToJSON(highScoreArray);
            
            // Empty the User Defaults - including previous game settings
            defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:));
        } else {
            print("No new game data");
        }
        
    }
    
    func readFromJSON() {
        do {
            guard let filePath = Bundle.main.path(forResource: "highScore", ofType: "json") else { return }
            let localData = NSData.init(contentsOfFile: filePath)! as Data;
            highScoreArray = try JSONDecoder().decode([HighScore].self, from: localData);
        } catch {
            print("error:\(error)");
        }
    }
    
    func saveToJSON(_ highScoreArray: [HighScore]) {
        do {
            guard let fileURL = Bundle.main.url(forResource: "highScore", withExtension: "json") else { return }
            let encoder = JSONEncoder();
            try encoder.encode(highScoreArray).write(to: fileURL);
        } catch {
            print(error.localizedDescription);
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
