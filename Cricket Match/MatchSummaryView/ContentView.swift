//
//  ContentView.swift
//  Cricket Match
//
//  Created by Rashif on 23/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedSegment = "Live"
    let segments = ["Upcoming", "Live", "Completed"]
    
    @ObservedObject private var dataLoader = MatchDataLoader()
    
    var body: some View {
        NavigationView {
            VStack {
                CustomSegmentedControl(selectedSegment: $selectedSegment, segments: segments)
                
                ScrollView {
                    if let matchDetails = dataLoader.matchDetails {
                        MatchSummaryCardView(match: matchDetails)
                    } else {
                        Text("Loading data...")
                    }
                }
            }
            .navigationBarTitle("Cricket Match", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {}) {
                Image(systemName: "line.horizontal.3")
            }, trailing: Button(action: {}) {
                Image(systemName: "bell")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
