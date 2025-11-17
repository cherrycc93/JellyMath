//
//  FoxMascot.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

/// A cute cartoon fox mascot for the JellyMath app
/// Designed for kids ages 3-12 with friendly, approachable features
struct FoxMascot: View {
    enum Pose {
        case smiling
        case waving
        case cheering
        case clapping
    }
    
    let pose: Pose
    let size: CGFloat
    
    init(pose: Pose = .smiling, size: CGFloat = 200) {
        self.pose = pose
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Main body group
            VStack(spacing: 0) {
                // Head with ears
                ZStack {
                    // Ears
                    HStack(spacing: size * 0.35) {
                        ear
                        ear
                    }
                    .offset(y: -size * 0.15)
                    
                    // Head (round face)
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 1.0, green: 0.5, blue: 0.2),
                                    Color(red: 1.0, green: 0.4, blue: 0.1)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: size * 0.6, height: size * 0.6)
                        .overlay(
                            // White cheek patches
                            HStack(spacing: size * 0.2) {
                                Circle()
                                    .fill(.white)
                                    .frame(width: size * 0.15, height: size * 0.15)
                                    .offset(y: size * 0.05)
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: size * 0.15, height: size * 0.15)
                                    .offset(y: size * 0.05)
                            }
                        )
                    
                    // Face features
                    VStack(spacing: size * 0.03) {
                        // Eyes
                        HStack(spacing: size * 0.12) {
                            eye
                            eye
                        }
                        .offset(y: -size * 0.05)
                        
                        // Nose
                        Capsule()
                            .fill(Color(red: 0.2, green: 0.1, blue: 0.05))
                            .frame(width: size * 0.08, height: size * 0.06)
                        
                        // Smile
                        smile
                            .stroke(Color(red: 0.2, green: 0.1, blue: 0.05), lineWidth: size * 0.02)
                            .frame(width: size * 0.2, height: size * 0.08)
                    }
                }
                .frame(width: size * 0.7, height: size * 0.65)
                
                // Body
                RoundedRectangle(cornerRadius: size * 0.15)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 1.0, green: 0.5, blue: 0.2),
                                Color(red: 1.0, green: 0.45, blue: 0.15)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: size * 0.5, height: size * 0.4)
                    .overlay(
                        // White belly patch
                        RoundedRectangle(cornerRadius: size * 0.1)
                            .fill(.white)
                            .frame(width: size * 0.25, height: size * 0.3)
                    )
            }
            
            // Arms based on pose
            armsForPose
            
            // Tail
            tail
                .offset(x: size * 0.3, y: size * 0.05)
        }
        .frame(width: size, height: size)
    }
    
    // MARK: - Body Parts
    
    private var ear: some View {
        ZStack {
            // Outer ear
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.5, blue: 0.2),
                            Color(red: 1.0, green: 0.4, blue: 0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: size * 0.15, height: size * 0.25)
            
            // Inner ear
            Ellipse()
                .fill(.white.opacity(0.8))
                .frame(width: size * 0.08, height: size * 0.15)
        }
    }
    
    private var eye: some View {
        ZStack {
            // White of eye
            Ellipse()
                .fill(.white)
                .frame(width: size * 0.12, height: size * 0.14)
            
            // Iris
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 0.4, green: 0.25, blue: 0.1),
                            Color(red: 0.3, green: 0.15, blue: 0.05)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: size * 0.04
                    )
                )
                .frame(width: size * 0.08, height: size * 0.08)
            
            // Pupil
            Circle()
                .fill(.black)
                .frame(width: size * 0.05, height: size * 0.05)
            
            // Sparkle
            Circle()
                .fill(.white)
                .frame(width: size * 0.02, height: size * 0.02)
                .offset(x: -size * 0.015, y: -size * 0.015)
        }
    }
    
    private var smile: Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addQuadCurve(
                to: CGPoint(x: size * 0.2, y: 0),
                control: CGPoint(x: size * 0.1, y: size * 0.08)
            )
        }
    }
    
    private var tail: some View {
        ZStack {
            // Main tail shape
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.5, blue: 0.2),
                            Color(red: 1.0, green: 0.4, blue: 0.1)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: size * 0.35, height: size * 0.2)
                .rotationEffect(.degrees(-30))
            
            // White tail tip
            Circle()
                .fill(.white)
                .frame(width: size * 0.12, height: size * 0.12)
                .offset(x: size * 0.12, y: -size * 0.05)
        }
    }
    
    private var arm: some View {
        RoundedRectangle(cornerRadius: size * 0.04)
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.5, blue: 0.2),
                        Color(red: 1.0, green: 0.45, blue: 0.15)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: size * 0.12, height: size * 0.3)
    }
    
    private var hand: some View {
        Circle()
            .fill(Color(red: 1.0, green: 0.5, blue: 0.2))
            .frame(width: size * 0.15, height: size * 0.15)
    }
    
    // MARK: - Pose-specific Arms
    
    @ViewBuilder
    private var armsForPose: some View {
        switch pose {
        case .smiling:
            smilingArms
        case .waving:
            wavingArms
        case .cheering:
            cheeringArms
        case .clapping:
            clappingArms
        }
    }
    
    private var smilingArms: some View {
        HStack(spacing: size * 0.5) {
            // Left arm - resting at side
            VStack(spacing: -size * 0.02) {
                arm
                hand
            }
            .offset(x: size * 0.02, y: size * 0.1)
            
            // Right arm - resting at side
            VStack(spacing: -size * 0.02) {
                arm
                hand
            }
            .offset(x: -size * 0.02, y: size * 0.1)
        }
    }
    
    private var wavingArms: some View {
        HStack(spacing: size * 0.5) {
            // Left arm - resting at side
            VStack(spacing: -size * 0.02) {
                arm
                hand
            }
            .offset(x: size * 0.02, y: size * 0.1)
            
            // Right arm - waving up
            VStack(spacing: -size * 0.02) {
                arm
                    .rotationEffect(.degrees(-45))
                hand
            }
            .offset(x: size * 0.05, y: -size * 0.1)
            .rotationEffect(.degrees(-45))
        }
    }
    
    private var cheeringArms: some View {
        HStack(spacing: size * 0.5) {
            // Left arm - raised
            VStack(spacing: -size * 0.02) {
                arm
                    .rotationEffect(.degrees(-20))
                hand
            }
            .offset(x: -size * 0.05, y: -size * 0.15)
            .rotationEffect(.degrees(-60))
            
            // Right arm - raised
            VStack(spacing: -size * 0.02) {
                arm
                    .rotationEffect(.degrees(20))
                hand
            }
            .offset(x: size * 0.05, y: -size * 0.15)
            .rotationEffect(.degrees(60))
        }
    }
    
    private var clappingArms: some View {
        HStack(spacing: size * 0.08) {
            // Left arm - clapping position
            VStack(spacing: -size * 0.02) {
                arm
                    .rotationEffect(.degrees(15))
                hand
            }
            .offset(x: size * 0.05, y: -size * 0.02)
            .rotationEffect(.degrees(-20))
            
            // Right arm - clapping position
            VStack(spacing: -size * 0.02) {
                arm
                    .rotationEffect(.degrees(-15))
                hand
            }
            .offset(x: -size * 0.05, y: -size * 0.02)
            .rotationEffect(.degrees(20))
        }
    }
}

// MARK: - Preview

#Preview("All Poses") {
    VStack(spacing: 40) {
        HStack(spacing: 30) {
            VStack {
                FoxMascot(pose: .smiling)
                Text("Smiling")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            VStack {
                FoxMascot(pose: .waving)
                Text("Waving")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        
        HStack(spacing: 30) {
            VStack {
                FoxMascot(pose: .cheering)
                Text("Cheering")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            VStack {
                FoxMascot(pose: .clapping)
                Text("Clapping")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
    .padding()
}

#Preview("Different Sizes") {
    HStack(spacing: 20) {
        FoxMascot(pose: .waving, size: 100)
        FoxMascot(pose: .waving, size: 150)
        FoxMascot(pose: .waving, size: 200)
        FoxMascot(pose: .waving, size: 250)
    }
    .padding()
}

#Preview("Animated Waving") {
    AnimatedWavingFox()
}

// MARK: - Animated Examples

/// Example of an animated waving fox
struct AnimatedWavingFox: View {
    @State private var isWaving = false
    
    var body: some View {
        FoxMascot(pose: isWaving ? .waving : .smiling, size: 200)
            .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isWaving)
            .onAppear {
                isWaving = true
            }
    }
}

/// Example of an animated clapping fox
struct AnimatedClappingFox: View {
    @State private var isClapping = false
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        FoxMascot(pose: .clapping, size: 200)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: scale)
            .onAppear {
                scale = 1.1
            }
    }
}

/// Example of an animated cheering fox
struct AnimatedCheeringFox: View {
    @State private var offset: CGFloat = 0
    
    var body: some View {
        FoxMascot(pose: .cheering, size: 200)
            .offset(y: offset)
            .animation(.easeInOut(duration: 0.4).repeatForever(autoreverses: true), value: offset)
            .onAppear {
                offset = -10
            }
    }
}
