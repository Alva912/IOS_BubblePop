//
//  JsonFileHelper.swift
//  BubblePop
//
//  Created by ljh on 22/1/21.
//

import Foundation

func readFromJSON(_ fileName: String) -> [HighScore] {
    do {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else { return [] }
        let localData = NSData.init(contentsOfFile: filePath)! as Data;

        let decoder = JSONDecoder();
        let highScores = try decoder.decode([HighScore].self, from: localData);

        return highScores;
    } catch {
        print(error.localizedDescription);
        return [];
    }
}

func saveToJSON(_ highScoreArray: [HighScore], _ fileName: String) {
    do {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else { return }
        let encoder = JSONEncoder();
        try encoder.encode(highScoreArray).write(to: fileURL);
    } catch {
        print(error.localizedDescription);
    }
}
