//
//  MainTabView.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

enum AppTab {
    case home
    case map
    case backpack
}

struct MainTabView: View {
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            NavigationStack {
                HomeView(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(AppTab.home)
            
            // Map Tab
            NavigationStack {
                MapView()
            }
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }
            .tag(AppTab.map)
            
            // Backpack Tab
            NavigationStack {
                BackpackView()
            }
            .tabItem {
                Label("Backpack", systemImage: "backpack.fill")
            }
            .tag(AppTab.backpack)
        }
        .tint(Color(red: 1.0, green: 0.5, blue: 0.4))
    }
}

#Preview {
    MainTabView()
        .environmentObject(StarBank.preview)
}
