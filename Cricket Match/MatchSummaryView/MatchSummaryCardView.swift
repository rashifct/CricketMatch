//
//  MatchSummaryCardView.swift
//  Cricket Match
//
//  Created by Rashif on 23/01/24.
//

import SwiftUI

struct MatchSummaryCardView: View {
    var match: MatchDetails

    var matchVerdict: String {
        let teamAScore = calculateTeamScore(team: match.teams[0])
        let teamBScore = calculateTeamScore(team: match.teams[1])
        let teamAWickets = calculateTotalWickets(teamName: match.teams[0].name)
        let teamBWickets = calculateTotalWickets(teamName: match.teams[1].name)

        if teamAScore > teamBScore {
            return "\(match.teams[0].name) won by \(teamAScore - teamBScore) runs"
        } else if teamBScore > teamAScore {
            return "\(match.teams[1].name) won by \(teamBScore - teamAScore) runs"
        } else if teamAWickets < teamBWickets {
            return "\(match.teams[0].name) won by \(teamBWickets - teamAWickets) wickets"
        } else if teamBWickets < teamAWickets {
            return "\(match.teams[1].name) won by \(teamAWickets - teamBWickets) wickets"
        } else {
            return "Match ended in a tie"
        }
    }

    var body: some View {
        NavigationLink(destination: DetailedScorecardView(match: match)) {
            VStack {
                Text("Format: \(match.format)")
                    .font(.headline)
                    .padding(.top)
                Text("\(match.toss) won the toss and chose to \(match.tossDecision)")
                    .font(.system(size: 13))
                    .font(.subheadline)
                    .padding(.top, 3)
                HStack {
                    VStack(alignment: .trailing, spacing: 5.0) {
                        HStack {
                            Image("india")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .cornerRadius(5)

                            Text(match.teams[0].name)
                        }
                        Text("\(calculateTeamScore(team: match.teams[0]))-\(calculateTotalWickets(teamName: match.teams[0].name)) (\(Int(calculateTotalOvers(teamName: match.teams[0].name))))")
                            .font(.subheadline)
                    }

                    Spacer()
                    Text("VS")
                        .font(.system(size: 15).weight(.bold))
                    Spacer()
                    VStack(alignment: .center, spacing: 5.0) {
                        HStack {
                            Image("australia")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .cornerRadius(5)

                            Text(match.teams[1].name)
                        }
                        Text("\(calculateTeamScore(team: match.teams[1]))-\(calculateTotalWickets(teamName: match.teams[1].name)) (\(Int(calculateTotalOvers(teamName: match.teams[1].name))))")
                            .font(.subheadline)
                    }

                }
                .padding(.horizontal)
                .padding(.top, 10)

                VStack(alignment: .leading, spacing: 10) {
                    Text(matchVerdict)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.horizontal, .top])
    }

    func calculateTeamScore(team: Team) -> Int {
        var totalScore = 0
        for player in team.players {
            totalScore += player.runs
        }
        return totalScore
    }

    func calculateTotalWickets(teamName: String) -> Int {
        let teamWickets = match.fallOfWickets.first { wicket in
            wicket.team == teamName
        }
        return teamWickets?.wickets.count ?? 0
    }

    func calculateTotalOvers(teamName: String) -> Double {
        let teamBowlers = match.teams.first { team in
            team.name == teamName
        }
        return teamBowlers?.bowlers.reduce(0.0, { $0 + Double($1.overs) }) ?? 0.0
    }
}
