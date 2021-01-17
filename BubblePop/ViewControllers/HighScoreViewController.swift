//
//  HighScoreViewController.swift
//  BubblePop
//
//  Created by ljh on 12/1/21.
//

import UIKit

struct HighScore {
    let playerName: String;
    let score: Int;
}

class HighScoreViewController: UIViewController {

    @IBOutlet weak var highScoreTableView: UITableView!
    
    // Add some sample data
    var highScoreArray: [HighScore] = [
        HighScore(playerName: "Alva", score: 60),
        HighScore(playerName: "Bella", score: 50),
        HighScore(playerName: "Christ", score: 40),
        HighScore(playerName: "Dan", score: 30),
        HighScore(playerName: "Ethan", score: 20),
        HighScore(playerName: "Florence", score: 10)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("\(highScoreArray)");
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
        
        //Retrive index for corresponding data
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
        
        //Retrive index for corresponding data
        let index = indexPath.row;
        let highScore = highScoreArray[index];
        
        print("Selectd row: \(cell?.textLabel?.text)");
        print("Selectd row: \(highScore)");
        
        // When cell selected, delete the data
        highScoreArray.remove(at: index);
//        tableView.reloadData();
        tableView.deleteRows(at: [indexPath], with: .fade);
        
    }
}
