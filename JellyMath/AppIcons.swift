//
//  AppIcons.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

// MARK: - Numbers Icon

/// A cute cartoon-style Numbers icon with smiling 1-2-3 characters
struct NumbersIcon: View {
    let size: CGFloat
    
    init(size: CGFloat = 80) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.4, green: 0.7, blue: 1.0),
                            Color(red: 0.3, green: 0.6, blue: 0.95)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                .shadow(color: .black.opacity(0.15), radius: size * 0.08, y: size * 0.04)
            
            // Numbers with faces
            HStack(spacing: size * 0.02) {
                smilingNumber("1", color: Color(red: 1.0, green: 0.3, blue: 0.4))
                    .offset(y: -size * 0.05)
                
                smilingNumber("2", color: Color(red: 1.0, green: 0.8, blue: 0.2))
                    .offset(y: size * 0.03)
                
                smilingNumber("3", color: Color(red: 0.3, green: 0.9, blue: 0.5))
                    .offset(y: -size * 0.02)
            }
        }
        .frame(width: size, height: size)
    }
    
    private func smilingNumber(_ number: String, color: Color) -> some View {
        ZStack {
            // Number background
            RoundedRectangle(cornerRadius: size * 0.08)
                .fill(color)
                .frame(width: size * 0.22, height: size * 0.35)
                .shadow(color: .black.opacity(0.2), radius: size * 0.02, y: size * 0.02)
            
            VStack(spacing: size * 0.02) {
                // Number text
                Text(number)
                    .font(.system(size: size * 0.18, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: -size * 0.02)
                
                // Smiley face
                ZStack {
                    // Eyes
                    HStack(spacing: size * 0.02) {
                        Circle()
                            .fill(.white)
                            .frame(width: size * 0.025, height: size * 0.025)
                        Circle()
                            .fill(.white)
                            .frame(width: size * 0.025, height: size * 0.025)
                    }
                    .offset(y: -size * 0.015)
                    
                    // Smile
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addQuadCurve(
                            to: CGPoint(x: size * 0.04, y: 0),
                            control: CGPoint(x: size * 0.02, y: size * 0.02)
                        )
                    }
                    .stroke(.white, style: StrokeStyle(lineWidth: size * 0.01, lineCap: .round))
                    .offset(y: size * 0.015)
                }
            }
        }
    }
}

// MARK: - Puzzles Icon

/// A cute Puzzles icon with rounded jigsaw pieces in pastel colors
struct PuzzlesIcon: View {
    let size: CGFloat
    
    init(size: CGFloat = 80) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.95, green: 0.9, blue: 1.0),
                            Color(red: 0.9, green: 0.85, blue: 0.98)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                .shadow(color: .black.opacity(0.15), radius: size * 0.08, y: size * 0.04)
            
            // Puzzle pieces arranged in a 2x2 grid
            ZStack {
                // Top-left piece (pink)
                puzzlePiece(color: Color(red: 1.0, green: 0.7, blue: 0.8))
                    .offset(x: -size * 0.12, y: -size * 0.12)
                    .rotationEffect(.degrees(-5))
                
                // Top-right piece (blue)
                puzzlePiece(color: Color(red: 0.6, green: 0.8, blue: 1.0))
                    .offset(x: size * 0.12, y: -size * 0.12)
                    .rotationEffect(.degrees(5))
                
                // Bottom-left piece (yellow)
                puzzlePiece(color: Color(red: 1.0, green: 0.9, blue: 0.5))
                    .offset(x: -size * 0.12, y: size * 0.12)
                    .rotationEffect(.degrees(3))
                
                // Bottom-right piece (green)
                puzzlePiece(color: Color(red: 0.6, green: 0.95, blue: 0.7))
                    .offset(x: size * 0.12, y: size * 0.12)
                    .rotationEffect(.degrees(-3))
            }
        }
        .frame(width: size, height: size)
    }
    
    private func puzzlePiece(color: Color) -> some View {
        ZStack {
            // Main piece body
            RoundedRectangle(cornerRadius: size * 0.04)
                .fill(color)
                .frame(width: size * 0.28, height: size * 0.28)
                .shadow(color: .black.opacity(0.15), radius: size * 0.03, y: size * 0.02)
            
            // Top knob
            Circle()
                .fill(color)
                .frame(width: size * 0.08, height: size * 0.08)
                .offset(y: -size * 0.18)
            
            // Right knob
            Circle()
                .fill(color)
                .frame(width: size * 0.08, height: size * 0.08)
                .offset(x: size * 0.18)
        }
    }
}

// MARK: - Achievements Icon

/// A cartoon trophy with a smiley face and sparkles
struct AchievementsIcon: View {
    let size: CGFloat
    
    init(size: CGFloat = 80) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.95, blue: 0.7),
                            Color(red: 1.0, green: 0.9, blue: 0.5)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                .shadow(color: .black.opacity(0.15), radius: size * 0.08, y: size * 0.04)
            
            // Trophy
            VStack(spacing: 0) {
                // Handles
                HStack(spacing: size * 0.25) {
                    handle
                        .scaleEffect(x: -1)
                    handle
                }
                .offset(y: size * 0.12)
                
                // Trophy cup body
                ZStack {
                    // Main cup
                    UnevenRoundedRectangle(
                        topLeadingRadius: size * 0.08,
                        bottomLeadingRadius: size * 0.04,
                        bottomTrailingRadius: size * 0.04,
                        topTrailingRadius: size * 0.08
                    )
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 1.0, green: 0.85, blue: 0.3),
                                Color(red: 1.0, green: 0.75, blue: 0.2)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: size * 0.35, height: size * 0.4)
                    .shadow(color: .black.opacity(0.2), radius: size * 0.03, y: size * 0.02)
                    
                    // Shine highlight
                    RoundedRectangle(cornerRadius: size * 0.02)
                        .fill(.white.opacity(0.4))
                        .frame(width: size * 0.06, height: size * 0.25)
                        .offset(x: -size * 0.08, y: -size * 0.02)
                    
                    // Smiley face on trophy
                    VStack(spacing: size * 0.015) {
                        // Eyes
                        HStack(spacing: size * 0.05) {
                            Circle()
                                .fill(Color(red: 0.4, green: 0.3, blue: 0.1))
                                .frame(width: size * 0.04, height: size * 0.04)
                            Circle()
                                .fill(Color(red: 0.4, green: 0.3, blue: 0.1))
                                .frame(width: size * 0.04, height: size * 0.04)
                        }
                        
                        // Smile
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addQuadCurve(
                                to: CGPoint(x: size * 0.08, y: 0),
                                control: CGPoint(x: size * 0.04, y: size * 0.03)
                            )
                        }
                        .stroke(Color(red: 0.4, green: 0.3, blue: 0.1), style: StrokeStyle(lineWidth: size * 0.012, lineCap: .round))
                    }
                    .offset(y: size * 0.02)
                }
                .offset(y: -size * 0.05)
                
                // Base
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: size * 0.02)
                        .fill(Color(red: 1.0, green: 0.8, blue: 0.3))
                        .frame(width: size * 0.25, height: size * 0.08)
                    
                    RoundedRectangle(cornerRadius: size * 0.03)
                        .fill(Color(red: 1.0, green: 0.75, blue: 0.2))
                        .frame(width: size * 0.35, height: size * 0.06)
                }
                .offset(y: -size * 0.05)
            }
            
            // Sparkles around trophy
            sparkle
                .offset(x: -size * 0.3, y: -size * 0.25)
            
            sparkle
                .scaleEffect(0.7)
                .offset(x: size * 0.32, y: -size * 0.2)
            
            sparkle
                .scaleEffect(0.5)
                .offset(x: size * 0.25, y: size * 0.25)
            
            sparkle
                .scaleEffect(0.6)
                .offset(x: -size * 0.28, y: size * 0.2)
        }
        .frame(width: size, height: size)
    }
    
    private var handle: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addQuadCurve(
                to: CGPoint(x: 0, y: size * 0.15),
                control: CGPoint(x: size * 0.06, y: size * 0.075)
            )
        }
        .stroke(
            Color(red: 1.0, green: 0.8, blue: 0.3),
            style: StrokeStyle(lineWidth: size * 0.05, lineCap: .round)
        )
    }
    
    private var sparkle: some View {
        ZStack {
            // Horizontal line
            RoundedRectangle(cornerRadius: size * 0.01)
                .fill(.white)
                .frame(width: size * 0.08, height: size * 0.015)
            
            // Vertical line
            RoundedRectangle(cornerRadius: size * 0.01)
                .fill(.white)
                .frame(width: size * 0.015, height: size * 0.08)
            
            // Diagonal lines
            RoundedRectangle(cornerRadius: size * 0.01)
                .fill(.white)
                .frame(width: size * 0.08, height: size * 0.015)
                .rotationEffect(.degrees(45))
            
            RoundedRectangle(cornerRadius: size * 0.01)
                .fill(.white)
                .frame(width: size * 0.08, height: size * 0.015)
                .rotationEffect(.degrees(-45))
        }
    }
}

// MARK: - Preview

#Preview("All Icons") {
    VStack(spacing: 40) {
        HStack(spacing: 40) {
            VStack {
                NumbersIcon(size: 100)
                Text("Numbers")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            VStack {
                PuzzlesIcon(size: 100)
                Text("Puzzles")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            VStack {
                AchievementsIcon(size: 100)
                Text("Achievements")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        
        // Different sizes
        HStack(spacing: 20) {
            NumbersIcon(size: 60)
            PuzzlesIcon(size: 80)
            AchievementsIcon(size: 100)
        }
    }
    .padding()
}

#Preview("Numbers Icon") {
    VStack(spacing: 30) {
        NumbersIcon(size: 80)
        NumbersIcon(size: 120)
        NumbersIcon(size: 160)
    }
    .padding()
}

#Preview("Puzzles Icon") {
    VStack(spacing: 30) {
        PuzzlesIcon(size: 80)
        PuzzlesIcon(size: 120)
        PuzzlesIcon(size: 160)
    }
    .padding()
}

#Preview("Achievements Icon") {
    VStack(spacing: 30) {
        AchievementsIcon(size: 80)
        AchievementsIcon(size: 120)
        AchievementsIcon(size: 160)
    }
    .padding()
}
