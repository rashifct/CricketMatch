//
//  MatchSummary.swift
//  Cricket Match
//
//  Created by Rashif on 23/01/24.
//

import Foundation

struct Root: Codable {
    let matchDetails: MatchDetails
}

struct MatchDetails: Codable {
    let format: String
    let toss: String
    let tossDecision: String
    let teams: [Team]
    let fallOfWickets: [FallOfWickets]
    
    enum CodingKeys: String, CodingKey {
        case format
        case toss
        case tossDecision = "toss_decision"
        case teams
        case fallOfWickets = "fallOfWickets"
    }
}

struct Team: Codable {
    let name: String
    let players: [Player]
    let bowlers: [Bowler]
}

struct Player: Codable {
    let name: String
    let runs: Int
    let balls: Int
    let fours: Int
    let sixes: Int
    let dismissal: Dismissal?
    var strikeRate: Double {
        return balls > 0 ? (Double(runs) / Double(balls)) * 100 : 0
    }
}

struct Bowler: Codable {
    let name: String
    let overs: Int
    let runsConceded: Int
    let wickets: Int
    var economyRate: Double {
        return overs > 0 ? Double(runsConceded) / Double(overs) : 0
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case overs
        case runsConceded = "runsConceded"
        case wickets
    }
}

struct Dismissal: Codable {
    let type: String
    let fielder: String?
    let bowler: String
}


struct FallOfWickets: Codable {
    let team: String
    let wickets: [WicketDetail]
}

struct WicketDetail: Codable {
    let player: String
    let score: Int
    let overs: Double
    let dismissal: Dismissal
}
