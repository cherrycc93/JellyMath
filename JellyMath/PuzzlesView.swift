//
//  PuzzlesView.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

struct PuzzlesView: View {
    var body: some View {
        ZStack {
            // Soft pastel background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.88, green: 0.93, blue: 0.98),
                    Color(red: 0.95, green: 0.97, blue: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Fox mascot
                FoxMascot(pose: .waving, size: 150)
                
                // Title
                Text("Puzzles")
                    .font(.system(size: 56, weight: .black, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.4, green: 0.6, blue: 1.0),
                                Color(red: 0.5, green: 0.7, blue: 1.0)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .white.opacity(0.8), radius: 2, x: 0, y: 2)
                
                // Icon
                PuzzlesIcon(size: 120)
                
                // Description
                Text("Solve fun math puzzles!")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.45))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Puzzles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PuzzlesView()
    }
}
