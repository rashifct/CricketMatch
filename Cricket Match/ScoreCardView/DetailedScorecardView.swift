//
//  DetailedScorecardView.swift
//  Cricket Match
//
//  Created by Rashif on 23/01/24.
//

import SwiftUI

struct DetailedScorecardView: View {
    var match: MatchDetails

    @State private var isExpandedTeamA = false
    @State private var isExpandedTeamB = false

    var body: some View {
        ScrollView {
            VStack {
                Text("Detailed Scorecard")
                    .font(.title)
                    .padding()

                AccordionView(title: "\(match.teams[0].name) - \(totalRunsAndWickets(team: match.teams[0]))",
                              isExpanded: $isExpandedTeamA) {
                    VStack {
                        PlayerListView(players: match.teams[0].players)
                        BowlerListView(bowlers: match.teams[0].bowlers)
                    }
                }.padding()

                AccordionView(title: "\(match.teams[1].name) - \(totalRunsAndWickets(team: match.teams[1]))",
                              isExpanded: $isExpandedTeamB) {
                    VStack {
                        PlayerListView(players: match.teams[1].players)
                        BowlerListView(bowlers: match.teams[1].bowlers)
                    }
                }.padding()
            }
        }.navigationBarTitle("Match Details", displayMode: .inline)
    }

    private func totalRunsAndWickets(team: Team) -> String {
        let totalRuns = team.players.reduce(0) { $0 + $1.runs }
        let wickets = team.players.filter { $0.dismissal?.type != "Not Out" }.count
        return "\(totalRuns)(\(wickets))"
    }
}

struct PlayerListView: View {
    var players: [Player]

    var body: some View {
        VStack {
            HStack {
                Text("Batter").styleAsHeader()
                Spacer()
                Group {
                    Text("R").styleAsStat()
                    Spacer()
                    Text("B").styleAsStat()
                    Spacer()
                    Text("4s").styleAsStat()
                    Spacer()
                    Text("6s").styleAsStat()
                    Spacer()
                    Text("SR").styleAsStat()
                }
            }.padding(.horizontal).padding(.top)
            
            ForEach(Array(players.enumerated()), id: \.offset) { _, player in
                playerRow(player)
            }
        }.styleAsCard()
    }

    private func playerRow(_ player: Player) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(player.name).styleAsName()
                Text(dismissalText(player.dismissal)).styleAsDismissal()
            }
            Spacer()
            Group {
                Text("\(player.runs)").styleAsStat()
                Spacer()
                Text("\(player.balls)").styleAsStat()
                Spacer()
                Text("\(player.fours)").styleAsStat()
                Spacer()
                Text("\(player.sixes)").styleAsStat()
                Spacer()
                Text("\(player.strikeRate, specifier: "%.2f")").styleAsStat()
            }
        }.padding([.horizontal, .vertical])
    }

    private func dismissalText(_ dismissal: Dismissal?) -> String {
        guard let dismissal = dismissal else { return "Not Out" }
        switch dismissal.type {
        case "Caught": return "c \(dismissal.fielder ?? "-") b \(dismissal.bowler)"
        case "LBW": return "lbw b \(dismissal.bowler)"
        case "Run Out": return "run out (\(dismissal.fielder ?? "-"))"
        case "Bowled": return "b \(dismissal.bowler)"
        case "Stumped": return "st \(dismissal.fielder ?? "-") b \(dismissal.bowler)"
        default: return dismissal.type
        }
    }
}

struct BowlerListView: View {
    var bowlers: [Bowler]

    var body: some View {
        VStack() {
            HStack {
                Text("Bowler").styleAsHeader()
                Spacer()
                Group {
                    Text("O").styleAsStat()
                    Spacer()
                    Text("R").styleAsStat()
                    Spacer()
                    Text("W").styleAsStat()
                    Spacer()
                    Text("ER").styleAsStat()
                }
            }.padding(.horizontal).padding(.top)
            
            ForEach(Array(bowlers.enumerated()), id: \.offset) { _, bowler in
                bowlerRow(bowler)
            }
        }.styleAsCard()
    }

    private func bowlerRow(_ bowler: Bowler) -> some View {
        HStack {
            Text(bowler.name).styleAsName()
            Spacer()
            Group {
                Text("\(bowler.overs)").styleAsStat()
                Spacer()
                Text("\(bowler.runsConceded)").styleAsStat()
                Spacer()
                Text("\(bowler.wickets)").styleAsStat()
                Spacer()
                Text("\(bowler.economyRate, specifier: "%.2f")").styleAsStat()
            }
        }.padding([.horizontal, .vertical])
    }
}

extension Text {
    func styleAsHeader() -> some View {
        self.font(.subheadline).fontWeight(.bold).frame(width: 100, alignment: .leading)
    }

    func styleAsStat() -> some View {
        self.font(.subheadline).frame(width: 30, alignment: .center)
    }

    func styleAsName() -> some View {
        self.font(.subheadline).frame(width: 100, alignment: .leading)
    }

    func styleAsDismissal() -> some View {
        self.font(.system(size: 9)).foregroundColor(.secondary).lineLimit(0).frame(width: 100, alignment: .leading)
    }
}

extension VStack {
    func styleAsCard() -> some View {
        self.frame(maxWidth: .infinity).background(Color.gray.opacity(0.2)).cornerRadius(5).padding([.bottom, .top])
    }
}
