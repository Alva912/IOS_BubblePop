//
//  JsonFileHelper.swift
//  BubblePop
//
//  Created by ljh on 22/1/21.
//

import Foundation

func readFromJSON() -> [HighScore] {
    do {
        let fileURL = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("highScore.json");
        let data = try Data(contentsOf: fileURL);
        let highScores = try JSONDecoder().decode([HighScore].self, from: data);
        return highScores;
    } catch {
        print(error.localizedDescription);
        return [];
    }
}

func saveToJSON(_ highScoreArray: [HighScore]) {
    do {
        let fileURL = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("highScore.json");
        let encoder = JSONEncoder();
        try encoder.encode(highScoreArray).write(to: fileURL);
    } catch {
        print(error.localizedDescription);
    }
}

//func readFromJSON() -> [HighScore] {
//    do {
//        guard let filePath = Bundle.main.path(forResource: "highScore", ofType: "json") else { return [] }
//        let localData = NSData.init(contentsOfFile: filePath)! as Data;
//
//        let decoder = JSONDecoder();
//        let highScores = try decoder.decode([HighScore].self, from: localData);
//
//        return highScores;
//    } catch {
//        print(error.localizedDescription);
//        return [];
//    }
//}
//
//func saveToJSON(_ highScoreArray: [HighScore]) {
//    do {
//        guard let fileURL = Bundle.main.url(forResource: "highScore", withExtension: "json") else { return }
//        let encoder = JSONEncoder();
//        try encoder.encode(highScoreArray).write(to: fileURL);
//    } catch {
//        print(error.localizedDescription);
//    }
//}
