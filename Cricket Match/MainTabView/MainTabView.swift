//
//  MainTabView.swift
//  Cricket Match
//
//  Created by Rashif on 23/01/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView() // Home View
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            Text("Matches View") // Matches or Games View
                .tabItem {
                    Image(systemName: "sportscourt.fill")
                    Text("Matches")
                }

            Text("Teams View") // Teams View
                .tabItem {
                    Image(systemName: "person.3.sequence.fill")
                    Text("Teams")
                }

            Text("Leagues View") // Leagues or Competitions View
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Leagues")
                }

            Text("Settings View") // Settings View
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
