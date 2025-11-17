//
//  JellyMathApp.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

@main
struct JellyMathApp: App {
    @StateObject private var starBank = StarBank()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(starBank)
        }
    }
}
