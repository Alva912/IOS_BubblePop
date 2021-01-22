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
    var highScoreArray: [HighScore] = readFromJSON();
    var sortedHighScore: [HighScore] = [];
    
    override func viewDidLoad() {
        sortedHighScore = highScoreArray.sorted{ $0.score > $1.score};
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
                itemsToDelete.append(sortedHighScore[indexPath.row]);
            }
            for item in itemsToDelete {
                if let index = sortedHighScore.firstIndex(where: {$0.playerName == item.playerName}){
                    sortedHighScore.remove(at: index);
                }
            }
            // Update UI
            highScoreTableView.deleteRows(at: selectedRows, with: .fade);
            // Update local data
            highScoreArray = sortedHighScore;
            saveToJSON(highScoreArray);
        }
        
    }
}

// DataSource - for Table View to display data
extension HighScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedHighScore.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrive cell from Prototype Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath);
        
        // Retrive index for corresponding data
        let index = indexPath.row;
        let highScore = sortedHighScore[index];
        
        // Assign the data(content) to UI
        cell.textLabel?.text = highScore.playerName;
        cell.detailTextLabel?.text = String(highScore.score);
        
        return cell;
    }
}

// Delegate - for Tabe View to peform actions
extension HighScoreViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            return true;
        } else {
            return false;
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sortedHighScore.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
        } else {
            // Do nothing
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
