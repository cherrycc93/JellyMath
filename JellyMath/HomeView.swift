//
//  HomeView.swift
//  JellyMath
//
//  Created by Claude on 11/17/25.
//

import SwiftUI

// MARK: - Main Home View
struct HomeView: View {
    @State private var isPlayButtonPressed = false
    @State private var foxWaveAnimation = false

    var body: some View {
        ZStack {
            // Sky blue background with clouds
            SkyBackgroundView()

            VStack(spacing: 0) {
                // Top section with fox mascot
                VStack {
                    Spacer()
                        .frame(height: 40)

                    FoxMascotView(isWaving: $foxWaveAnimation)
                        .frame(width: 150, height: 150)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                                foxWaveAnimation = true
                            }
                        }

                    Text("Let's Learn Math!")
                        .font(.custom("Chalkboard SE", size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.3))
                        .padding(.top, 10)
                        .shadow(color: .white.opacity(0.5), radius: 2, x: 0, y: 2)
                }
                .padding(.top, 20)

                Spacer()

                // Large yellow PLAY button
                PlayButtonView(isPressed: $isPlayButtonPressed)
                    .padding(.horizontal, 60)

                Spacer()
                    .frame(height: 40)

                // Three feature icons
                HStack(spacing: 25) {
                    FeatureIconView(icon: "123", label: "Numbers", color: Color(red: 1.0, green: 0.6, blue: 0.8))
                    FeatureIconView(icon: "puzzlepiece.fill", label: "Puzzles", color: Color(red: 0.6, green: 0.8, blue: 1.0))
                    FeatureIconView(icon: "star.fill", label: "Achievements", color: Color(red: 1.0, green: 0.9, blue: 0.5))
                }
                .padding(.horizontal, 30)

                Spacer()

                // Bottom navigation bar
                BottomNavigationBar()
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Sky Background with Clouds
struct SkyBackgroundView: View {
    var body: some View {
        ZStack {
            // Sky gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.53, green: 0.81, blue: 0.98),
                    Color(red: 0.68, green: 0.85, blue: 0.98)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Clouds
            CloudView()
                .offset(x: -100, y: 80)

            CloudView()
                .scaleEffect(0.7)
                .offset(x: 120, y: 150)

            CloudView()
                .scaleEffect(0.5)
                .offset(x: -80, y: 200)

            CloudView()
                .scaleEffect(0.8)
                .offset(x: 80, y: 50)
        }
    }
}

// MARK: - Cloud Shape
struct CloudView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 60, height: 60)
                .offset(x: -20, y: 0)

            Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 80, height: 80)
                .offset(x: 0, y: -5)

            Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 70, height: 70)
                .offset(x: 25, y: 0)

            Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 50, height: 50)
                .offset(x: 40, y: 5)
        }
    }
}

// MARK: - Fox Mascot
struct FoxMascotView: View {
    @Binding var isWaving: Bool

    var body: some View {
        ZStack {
            // Fox body
            Circle()
                .fill(Color(red: 1.0, green: 0.5, blue: 0.2))
                .frame(width: 100, height: 100)
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)

            // Ears
            Group {
                // Left ear
                Triangle()
                    .fill(Color(red: 1.0, green: 0.5, blue: 0.2))
                    .frame(width: 30, height: 40)
                    .offset(x: -30, y: -50)

                // Left ear inner
                Triangle()
                    .fill(Color.white)
                    .frame(width: 15, height: 20)
                    .offset(x: -30, y: -45)

                // Right ear
                Triangle()
                    .fill(Color(red: 1.0, green: 0.5, blue: 0.2))
                    .frame(width: 30, height: 40)
                    .offset(x: 30, y: -50)

                // Right ear inner
                Triangle()
                    .fill(Color.white)
                    .frame(width: 15, height: 20)
                    .offset(x: 30, y: -45)
            }

            // Face features
            Group {
                // Eyes
                Circle()
                    .fill(Color.white)
                    .frame(width: 25, height: 25)
                    .overlay(
                        Circle()
                            .fill(Color.black)
                            .frame(width: 12, height: 12)
                            .offset(x: 3, y: 2)
                    )
                    .offset(x: -20, y: -10)

                Circle()
                    .fill(Color.white)
                    .frame(width: 25, height: 25)
                    .overlay(
                        Circle()
                            .fill(Color.black)
                            .frame(width: 12, height: 12)
                            .offset(x: 3, y: 2)
                    )
                    .offset(x: 20, y: -10)

                // Nose
                Circle()
                    .fill(Color.black)
                    .frame(width: 12, height: 12)
                    .offset(x: 0, y: 5)

                // Smile
                Path { path in
                    path.move(to: CGPoint(x: -15, y: 15))
                    path.addQuadCurve(
                        to: CGPoint(x: 15, y: 15),
                        control: CGPoint(x: 0, y: 25)
                    )
                }
                .stroke(Color.black, lineWidth: 3)
                .offset(x: 0, y: 5)
            }

            // Waving hand/paw
            Circle()
                .fill(Color(red: 1.0, green: 0.5, blue: 0.2))
                .frame(width: 35, height: 35)
                .offset(x: 65, y: -20)
                .rotationEffect(.degrees(isWaving ? -20 : 20))
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
        }
    }
}

// MARK: - Triangle Shape for Fox Ears
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Play Button
struct PlayButtonView: View {
    @Binding var isPressed: Bool

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed = false
            }
        }) {
            ZStack {
                // Button shadow
                Circle()
                    .fill(Color(red: 0.9, green: 0.7, blue: 0.0))
                    .frame(width: 180, height: 180)
                    .offset(y: isPressed ? 0 : 8)

                // Main button
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 1.0, green: 0.95, blue: 0.2),
                                Color(red: 1.0, green: 0.8, blue: 0.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 180, height: 180)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 4)
                            .frame(width: 170, height: 170)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: isPressed ? 2 : 6)
                    .scaleEffect(isPressed ? 0.95 : 1.0)

                // PLAY text
                Text("PLAY")
                    .font(.custom("Chalkboard SE", size: 42))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: Color(red: 0.8, green: 0.6, blue: 0.0), radius: 0, x: 2, y: 2)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Feature Icon
struct FeatureIconView: View {
    let icon: String
    let label: String
    let color: Color
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
                    RoundedRectangle(cornerRadius: 25)
                        .fill(color.opacity(0.6))
                        .frame(width: 85, height: 85)
                        .offset(y: isPressed ? 0 : 4)

                    // Main icon background
                    RoundedRectangle(cornerRadius: 25)
                        .fill(color)
                        .frame(width: 85, height: 85)
                        .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: isPressed ? 1 : 4)
                        .scaleEffect(isPressed ? 0.95 : 1.0)

                    // Icon symbol
                    if icon == "123" {
                        Text("123")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: icon)
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
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

// MARK: - Bottom Navigation Bar
struct BottomNavigationBar: View {
    var body: some View {
        HStack(spacing: 0) {
            // Map button
            NavigationItemView(icon: "map.fill", label: "Map", color: Color(red: 0.5, green: 0.8, blue: 0.6))

            Spacer()

            // Stars counter
            HStack(spacing: 8) {
                Image(systemName: "star.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))

                Text("128")
                    .font(.custom("Chalkboard SE", size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.4))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.8))
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            )

            Spacer()

            // Backpack button
            NavigationItemView(icon: "backpack.fill", label: "Backpack", color: Color(red: 0.9, green: 0.6, blue: 0.4))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.85))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

// MARK: - Navigation Item
struct NavigationItemView: View {
    let icon: String
    let label: String
    let color: Color
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
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        .scaleEffect(isPressed ? 0.9 : 1.0)

                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }

                Text(label)
                    .font(.custom("Chalkboard SE", size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.4))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
