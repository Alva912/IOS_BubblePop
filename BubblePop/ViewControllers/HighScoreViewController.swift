//
//  HighScoreViewController.swift
//  BubblePop
//
//  Created by ljh on 12/1/21.
//

import UIKit

class HighScoreViewController: UIViewController {
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    // Retrive history data from json file
    var highScoreArray: [HighScore] = readFromJSON("HighScore").sorted{ $0.score > $1.score};
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = editButtonItem;
        highScoreTableView.allowsMultipleSelectionDuringEditing = true;
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated);
        highScoreTableView.setEditing(editing, animated: true);
    }

    @IBAction func deleteButtonOnClick(_ sender: Any) {
        if let selectedRows = highScoreTableView.indexPathsForSelectedRows {
            var itemsToDelete: [HighScore] = [];
            for indexPath in selectedRows  {
                itemsToDelete.append(highScoreArray[indexPath.row]);
            }
            for item in itemsToDelete {
                if let index = highScoreArray.firstIndex(where: {$0.playerName == item.playerName}){
                    highScoreArray.remove(at: index);
                }
            }
            // Update UI
            highScoreTableView.deleteRows(at: selectedRows, with: .fade);
            // Update local data
            saveToJSON(highScoreArray, "HighScore");
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
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete;
    }
}
