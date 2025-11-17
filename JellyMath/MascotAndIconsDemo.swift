//
//  MascotAndIconsDemo.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

/// A demo view showcasing the fox mascot and app icons together
struct MascotAndIconsDemo: View {
    @State private var selectedPose: FoxMascot.Pose = .waving
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Title
                Text("JellyMath Design System")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.orange, .pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                // Fox Mascot Section
                VStack(spacing: 20) {
                    Text("Meet Foxy!")
                        .font(.title2.bold())
                    
                    FoxMascot(pose: selectedPose, size: 200)
                    
                    // Pose selector
                    HStack(spacing: 15) {
                        poseButton(.smiling, "😊")
                        poseButton(.waving, "👋")
                        poseButton(.cheering, "🎉")
                        poseButton(.clapping, "👏")
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                )
                
                Divider()
                    .padding(.horizontal)
                
                // App Icons Section
                VStack(spacing: 20) {
                    Text("App Icons")
                        .font(.title2.bold())
                    
                    HStack(spacing: 30) {
                        VStack(spacing: 10) {
                            NumbersIcon(size: 100)
                            Text("Numbers")
                                .font(.caption.bold())
                        }
                        
                        VStack(spacing: 10) {
                            PuzzlesIcon(size: 100)
                            Text("Puzzles")
                                .font(.caption.bold())
                        }
                        
                        VStack(spacing: 10) {
                            AchievementsIcon(size: 100)
                            Text("Achievements")
                                .font(.caption.bold())
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                )
                
                // Usage Examples
                VStack(spacing: 20) {
                    Text("Usage Examples")
                        .font(.title2.bold())
                    
                    // Example card with fox and icon
                    HStack(spacing: 20) {
                        FoxMascot(pose: .cheering, size: 80)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                NumbersIcon(size: 40)
                                Text("Learn Numbers")
                                    .font(.headline)
                            }
                            Text("Start your math journey!")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(red: 0.95, green: 0.97, blue: 1.0))
                    )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                )
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.98, green: 0.95, blue: 1.0),
                    Color(red: 0.95, green: 0.98, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
    
    private func poseButton(_ pose: FoxMascot.Pose, _ emoji: String) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedPose = pose
            }
        } label: {
            Text(emoji)
                .font(.title)
                .frame(width: 60, height: 60)
                .background(
                    Circle()
                        .fill(selectedPose == pose ? Color.orange.opacity(0.3) : Color.gray.opacity(0.1))
                )
        }
    }
}

#Preview {
    MascotAndIconsDemo()
}
