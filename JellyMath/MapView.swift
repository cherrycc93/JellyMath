//
//  MapView.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

// MARK: - Level Model

struct MathLevel: Identifiable {
    let id: Int
    let number: Int
    let title: String
    let icon: String
    let color: Color
    let isLocked: Bool
    let starsRequired: Int
}

// MARK: - Map View

struct MapView: View {
    @EnvironmentObject private var starBank: StarBank
    
    // Dummy level data
    let levels: [MathLevel] = [
        MathLevel(id: 1, number: 1, title: "Counting Fun", icon: "1.circle.fill", color: Color(red: 1.0, green: 0.7, blue: 0.8), isLocked: false, starsRequired: 0),
        MathLevel(id: 2, number: 2, title: "Add & Subtract", icon: "plus.circle.fill", color: Color(red: 0.7, green: 0.85, blue: 1.0), isLocked: false, starsRequired: 10),
        MathLevel(id: 3, number: 3, title: "Shape Match", icon: "square.circle.fill", color: Color(red: 1.0, green: 0.9, blue: 0.6), isLocked: false, starsRequired: 25),
        MathLevel(id: 4, number: 4, title: "Pattern Play", icon: "star.circle.fill", color: Color(red: 0.8, green: 1.0, blue: 0.8), isLocked: true, starsRequired: 50),
        MathLevel(id: 5, number: 5, title: "Number Ninja", icon: "bolt.circle.fill", color: Color(red: 1.0, green: 0.85, blue: 0.9), isLocked: true, starsRequired: 80),
        MathLevel(id: 6, number: 6, title: "Math Master", icon: "crown.fill", color: Color(red: 0.9, green: 0.8, blue: 1.0), isLocked: true, starsRequired: 120),
    ]
    
    var body: some View {
        ZStack {
            // Soft pastel background with clouds
            MapBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar with title and stars
                HStack {
                    // Title
                    Text("Your Journey")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.4, green: 0.8, blue: 0.6),
                                    Color(red: 0.5, green: 0.9, blue: 0.7)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: .white.opacity(0.8), radius: 2, x: 0, y: 2)
                    
                    Spacer()
                    
                    // Star counter pill (from HomeView style)
                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 1.0, green: 0.9, blue: 0.3),
                                        Color(red: 1.0, green: 0.85, blue: 0.2)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .shadow(color: Color(red: 1.0, green: 0.8, blue: 0.0), radius: 1, x: 0, y: 1)
                        
                        Text("\(starBank.stars)")
                            .font(.system(size: 24, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: Color(red: 0.9, green: 0.7, blue: 0.2), radius: 0, x: 1, y: 1)
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 1.0, green: 0.9, blue: 0.5),
                                        Color(red: 1.0, green: 0.85, blue: 0.4)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.4),
                                                Color.white.opacity(0.0)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .center
                                        )
                                    )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.6), lineWidth: 2)
                            )
                            .shadow(color: Color(red: 1.0, green: 0.9, blue: 0.3).opacity(0.4), radius: 8, x: 0, y: 4)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                    )
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                // Scrollable level path
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        ForEach(levels) { level in
                            LevelCard(
                                level: level,
                                canUnlock: starBank.stars >= level.starsRequired
                            )
                        }
                        
                        // Test reward button (inline jelly-style)
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                starBank.addStars(5)
                            }
                        }) {
                            HStack(spacing: 10) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Test reward +5")
                                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 22)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 1.0, green: 0.75, blue: 0.35),
                                                Color(red: 1.0, green: 0.65, blue: 0.3)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 22)
                                            .stroke(Color.white.opacity(0.8), lineWidth: 2)
                                    )
                                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 5)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                }
            }
            
            // Fox mascot in bottom-left corner
            VStack {
                Spacer()
                HStack {
                    FoxMascot(pose: .cheering, size: 100)
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Map Background

struct MapBackgroundView: View {
    var body: some View {
        ZStack {
            // Soft gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.88, green: 0.93, blue: 0.98),
                    Color(red: 0.93, green: 0.95, blue: 0.99),
                    Color(red: 0.95, green: 0.97, blue: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Soft clouds
            SoftCloudView()
                .offset(x: -110, y: 120)
            
            SoftCloudView()
                .scaleEffect(0.7)
                .offset(x: 130, y: 200)
            
            SoftCloudView()
                .scaleEffect(0.6)
                .offset(x: -70, y: 350)
            
            SoftCloudView()
                .scaleEffect(0.8)
                .offset(x: 90, y: 80)
        }
    }
}

// MARK: - Level Card

struct LevelCard: View {
    let level: MathLevel
    let canUnlock: Bool
    @State private var isPressed = false
    
    var isAccessible: Bool {
        !level.isLocked || canUnlock
    }
    
    var body: some View {
        Button(action: {
            if isAccessible {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isPressed = false
                }
                // TODO: Navigate to level
            }
        }) {
            HStack(spacing: 20) {
                // Level icon circle
                ZStack {
                    // Shadow layer
                    Circle()
                        .fill(level.color.opacity(0.4))
                        .frame(width: 84, height: 84)
                        .offset(y: isPressed ? 2 : 6)
                        .blur(radius: 4)
                    
                    // Main circle
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    level.color,
                                    level.color.opacity(0.85)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 84, height: 84)
                        .overlay(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.5),
                                            Color.white.opacity(0.0)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .center
                                    )
                                )
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.6), lineWidth: 4)
                        )
                        .shadow(color: level.color.opacity(0.5), radius: 10, x: 0, y: 6)
                        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: isPressed ? 3 : 8)
                        .scaleEffect(isPressed ? 0.93 : 1.0)
                        .offset(y: isPressed ? 3 : 0)
                    
                    // Icon or lock
                    if level.isLocked && !canUnlock {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    } else {
                        Image(systemName: level.icon)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    }
                }
                
                // Level info
                VStack(alignment: .leading, spacing: 8) {
                    // Level number
                    Text("Level \(level.number)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.5))
                    
                    // Level title
                    Text(level.title)
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.45))
                        .shadow(color: .white.opacity(0.8), radius: 1, x: 0, y: 1)
                    
                    // Stars required (if locked)
                    if level.isLocked {
                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(canUnlock ? Color(red: 1.0, green: 0.8, blue: 0.2) : Color(red: 0.6, green: 0.6, blue: 0.65))
                            
                            Text("\(level.starsRequired) stars to unlock")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundColor(canUnlock ? Color(red: 1.0, green: 0.8, blue: 0.2) : Color(red: 0.6, green: 0.6, blue: 0.65))
                        }
                    }
                }
                
                Spacer()
                
                // Arrow indicator (if unlocked)
                if isAccessible {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(level.color)
                        .shadow(color: .white.opacity(0.8), radius: 1, x: 0, y: 1)
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(
                        LinearGradient(
                            colors: [
                                .white.opacity(isAccessible ? 0.95 : 0.7),
                                .white.opacity(isAccessible ? 0.9 : 0.6)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.6),
                                        Color.white.opacity(0.0)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .center
                                )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(color: .black.opacity(0.08), radius: 15, x: 0, y: 8)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .opacity(isAccessible ? 1.0 : 0.7)
    }
}

#Preview {
    NavigationStack {
        MapView()
            .environmentObject(StarBank.preview)
    }
}

