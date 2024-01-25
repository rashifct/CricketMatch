//
//  MatchDataLoader.swift
//  Cricket Match
//
//  Created by Rashif on 23/01/24.
//

import Foundation

class MatchDataLoader: ObservableObject {
    @Published var matchDetails: MatchDetails?

    init() {
        if let loadedData = loadJSON() {
            self.matchDetails = loadedData.matchDetails
        } else {
            print("Failed to load or decode data")
        }
    }

    func loadJSON() -> Root? {
        guard let url = Bundle.main.url(forResource: "status", withExtension: "json") else {
            print("Failed to find status.json in bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let root = try decoder.decode(Root.self, from: data)
            return root
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
