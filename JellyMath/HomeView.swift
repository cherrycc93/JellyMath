//
//  HomeView.swift
//  JellyMath
//
//  Created by Claude on 11/17/25.
//

import SwiftUI

// MARK: - Main Home View
struct HomeView: View {
    @EnvironmentObject private var starBank: StarBank
    @Binding var selectedTab: AppTab
    @State private var isPlayButtonPressed = false
    @State private var foxBounce = false
    @State private var playButtonPulse = false

    var body: some View {
        ZStack {
            // Soft pastel sky background
            SoftSkyBackgroundView()

            VStack(spacing: 0) {
                // Top section with fox mascot
                VStack(spacing: 16) {
                    Spacer()
                        .frame(height: 50)

                    // Animated fox mascot
                    FoxMascot(pose: .waving, size: 140)
                        .offset(y: foxBounce ? -8 : 0)
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration: 1.2)
                                .repeatForever(autoreverses: true)
                            ) {
                                foxBounce = true
                            }
                        }

                    Text("Let's Learn Math!")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color(red: 1.0, green: 0.5, blue: 0.4),
                                    Color(red: 1.0, green: 0.4, blue: 0.3)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: .white.opacity(0.8), radius: 2, x: 0, y: 2)
                }
                .padding(.top, 20)

                Spacer()

                // Large jelly PLAY button - switches to Map tab
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isPlayButtonPressed = true
                        selectedTab = .map
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isPlayButtonPressed = false
                    }
                }) {
                    JellyPlayButton(isPressed: $isPlayButtonPressed)
                        .scaleEffect(playButtonPulse ? 1.05 : 1.0)
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: true)
                            ) {
                                playButtonPulse = true
                            }
                        }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 60)

                Spacer()

                // Three feature icons - using the new custom icons
                HStack(spacing: 25) {
                    NavigationLink(destination: NumbersView()) {
                        FeatureIconWithCustomView(
                            customIcon: NumbersIcon(size: 65),
                            label: "Numbers",
                            backgroundColor: Color(red: 1.0, green: 0.6, blue: 0.8)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: PuzzlesView()) {
                        FeatureIconWithCustomView(
                            customIcon: PuzzlesIcon(size: 65),
                            label: "Puzzles",
                            backgroundColor: Color(red: 0.6, green: 0.8, blue: 1.0)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: AchievementsView()) {
                        FeatureIconWithCustomView(
                            customIcon: AchievementsIcon(size: 65),
                            label: "Achievements",
                            backgroundColor: Color(red: 1.0, green: 0.9, blue: 0.5)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 30)

                Spacer()
                    .frame(height: 20)

                // Bottom navigation bar with Map, Stars, and Backpack
                JellyBottomNavBar(selectedTab: $selectedTab)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Soft Sky Background
struct SoftSkyBackgroundView: View {
    var body: some View {
        ZStack {
            // Soft pastel gradient
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
                .offset(x: -120, y: 100)

            SoftCloudView()
                .scaleEffect(0.8)
                .offset(x: 140, y: 180)

            SoftCloudView()
                .scaleEffect(0.6)
                .offset(x: -90, y: 250)

            SoftCloudView()
                .scaleEffect(0.9)
                .offset(x: 100, y: 60)
        }
    }
}

// MARK: - Soft Cloud Shape
struct SoftCloudView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.5))
                .frame(width: 70, height: 70)
                .blur(radius: 1)
                .offset(x: -25, y: 0)

            Circle()
                .fill(Color.white.opacity(0.5))
                .frame(width: 90, height: 90)
                .blur(radius: 1)
                .offset(x: 0, y: -8)

            Circle()
                .fill(Color.white.opacity(0.5))
                .frame(width: 80, height: 80)
                .blur(radius: 1)
                .offset(x: 30, y: 0)

            Circle()
                .fill(Color.white.opacity(0.5))
                .frame(width: 60, height: 60)
                .blur(radius: 1)
                .offset(x: 50, y: 8)
        }
    }
}

// MARK: - Jelly Play Button
struct JellyPlayButton: View {
    @Binding var isPressed: Bool

    var body: some View {
        ZStack {
            // 3D shadow layer (bottom)
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.95, green: 0.75, blue: 0.2),
                            Color(red: 0.9, green: 0.7, blue: 0.15)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 200, height: 200)
                .offset(y: isPressed ? 4 : 10)
                .blur(radius: 4)

            // Main jelly button
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 1.0, green: 0.93, blue: 0.4),
                            Color(red: 1.0, green: 0.85, blue: 0.2)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 200, height: 200)
                .overlay(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.4),
                                    Color.white.opacity(0.0)
                                ],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                        .frame(width: 200, height: 200)
                )
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.5), lineWidth: 6)
                        .frame(width: 188, height: 188)
                )
                .shadow(color: Color(red: 1.0, green: 0.8, blue: 0.3).opacity(0.5), radius: 15, x: 0, y: 8)
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: isPressed ? 4 : 10)
                .scaleEffect(isPressed ? 0.93 : 1.0)
                .offset(y: isPressed ? 4 : 0)

            // PLAY text
            Text("PLAY")
                .font(.system(size: 48, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .white,
                            Color(red: 1.0, green: 0.98, blue: 0.9)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: Color(red: 0.9, green: 0.7, blue: 0.2), radius: 0, x: 2, y: 3)
                .offset(y: isPressed ? 2 : 0)
        }
    }
}

// MARK: - Jelly Category Card (used by navigation links)
struct JellyCategoryCard<Content: View>: View {
    let icon: Content
    let label: String
    let backgroundColor: Color
    @State private var isPressed = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                // 3D shadow layer
                RoundedRectangle(cornerRadius: 22)
                    .fill(backgroundColor.opacity(0.4))
                    .frame(width: 90, height: 90)
                    .offset(y: isPressed ? 2 : 6)
                    .blur(radius: 3)

                // Main jelly card
                RoundedRectangle(cornerRadius: 22)
                    .fill(
                        LinearGradient(
                            colors: [
                                backgroundColor,
                                backgroundColor.opacity(0.85)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 90, height: 90)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
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
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.white.opacity(0.6), lineWidth: 3)
                    )
                    .shadow(color: backgroundColor.opacity(0.4), radius: 8, x: 0, y: 6)
                    .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: isPressed ? 3 : 8)
                    .scaleEffect(isPressed ? 0.93 : 1.0)
                    .offset(y: isPressed ? 3 : 0)

                // Icon
                icon
                    .frame(width: 70, height: 70)
                    .scaleEffect(0.75)
                    .offset(y: isPressed ? 2 : 0)
            }

            // Label
            Text(label)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.45))
                .shadow(color: .white.opacity(0.8), radius: 1, x: 0, y: 1)
        }
    }
}

// MARK: - Feature Icon with Custom View
struct FeatureIconWithCustomView<Content: View>: View {
    let customIcon: Content
    let label: String
    let backgroundColor: Color
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed = false
            }
        }) {
            VStack(spacing: 8) {
                ZStack {
                    // Icon shadow
                    RoundedRectangle(cornerRadius: 20)
                        .fill(backgroundColor.opacity(0.4))
                        .frame(width: 85, height: 85)
                        .offset(y: isPressed ? 0 : 4)

                    // Custom icon
                    customIcon
                        .frame(width: 85, height: 85)
                        .scaleEffect(isPressed ? 0.95 : 1.0)
                        .offset(y: isPressed ? 2 : 0)
                }

                // Label
                Text(label)
                    .font(.custom("Chalkboard SE", size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.4))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Jelly Bottom Navigation Bar
struct JellyBottomNavBar: View {
    @EnvironmentObject private var starBank: StarBank
    @Binding var selectedTab: AppTab
    
    var body: some View {
        HStack(spacing: 0) {
            // Map button
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedTab = .map
                }
            }) {
                JellyNavButton(
                    icon: "map.fill",
                    label: "Map",
                    color: Color(red: 0.6, green: 0.85, blue: 0.75)
                )
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()

            // Stars counter pill
            HStack(spacing: 10) {
                Image(systemName: "star.fill")
                    .font(.system(size: 28, weight: .bold))
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
                    .shadow(color: Color(red: 1.0, green: 0.8, blue: 0.0), radius: 2, x: 0, y: 1)
                
                Text("\(starBank.stars)")
                    .font(.system(size: 36, weight: .black, design: .rounded))
                    .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.45))
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white.opacity(0.95))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 3)
                    )
                    .shadow(color: Color(red: 1.0, green: 0.9, blue: 0.3).opacity(0.3), radius: 8, x: 0, y: 4)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
            )

            Spacer()

            // Backpack button
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedTab = .backpack
                }
            }) {
                JellyNavButton(
                    icon: "backpack.fill",
                    label: "Backpack",
                    color: Color(red: 1.0, green: 0.8, blue: 0.7)
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.95),
                            .white.opacity(0.9)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 4)
                )
                .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: -8)
        )
    }
}

// MARK: - Jelly Navigation Button
struct JellyNavButton: View {
    let icon: String
    let label: String
    let color: Color
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // Shadow layer
                Circle()
                    .fill(color.opacity(0.4))
                    .frame(width: 62, height: 62)
                    .offset(y: isPressed ? 1 : 4)
                    .blur(radius: 3)

                // Main circle with jelly effect
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                color,
                                color.opacity(0.85)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 62, height: 62)
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
                            .stroke(Color.white.opacity(0.6), lineWidth: 3)
                    )
                    .shadow(color: color.opacity(0.4), radius: 6, x: 0, y: 4)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: isPressed ? 2 : 6)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .offset(y: isPressed ? 2 : 0)

                Image(systemName: icon)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                    .offset(y: isPressed ? 1 : 0)
            }

            Text(label)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.45))
                .shadow(color: .white.opacity(0.8), radius: 1, x: 0, y: 1)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        HomeView(selectedTab: .constant(.home))
            .environmentObject(StarBank.preview)
    }
}
