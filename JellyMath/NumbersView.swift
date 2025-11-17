//
//  NumbersView.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

struct NumbersView: View {
    @EnvironmentObject private var starBank: StarBank
    @State private var targetNumber: Int = 1
    @State private var showStarBurst = false
    @State private var starBurstPosition: CGPoint = .zero
    @State private var shakingNumber: Int? = nil
    @State private var highlightedNumber: Int? = nil
    
    let numbers = Array(1...10)
    let pastelColors: [Color] = [
        Color(red: 1.0, green: 0.85, blue: 0.9),   // Pink
        Color(red: 1.0, green: 0.92, blue: 0.8),   // Peach
        Color(red: 1.0, green: 0.95, blue: 0.8),   // Light Yellow
        Color(red: 0.85, green: 0.95, blue: 0.85), // Mint
        Color(red: 0.85, green: 0.93, blue: 1.0),  // Sky Blue
        Color(red: 0.92, green: 0.85, blue: 1.0),  // Lavender
        Color(red: 1.0, green: 0.88, blue: 0.95),  // Rose
        Color(red: 0.95, green: 0.95, blue: 0.85), // Cream
        Color(red: 0.88, green: 0.95, blue: 0.95), // Aqua
        Color(red: 0.98, green: 0.9, blue: 0.9)    // Blush
    ]
    
    var body: some View {
        ZStack {
            // Soft pastel background
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
            
            VStack(spacing: 20) {
                // Top section with fox and title
                VStack(spacing: 16) {
                    // Fox mascot
                    FoxMascot(pose: .cheering, size: 100)
                    
                    // Title
                    Text("Tap the Number I Say!")
                        .font(.system(size: 32, weight: .black, design: .rounded))
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
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    // Star counter
                    HStack(spacing: 10) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 1.0, green: 0.9, blue: 0.3),
                                        Color(red: 1.0, green: 0.8, blue: 0.2)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .shadow(color: Color(red: 1.0, green: 0.8, blue: 0.0), radius: 2, x: 0, y: 1)
                        
                        Text("\(starBank.stars)")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.45))
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white.opacity(0.9))
                            .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                    )
                }
                .padding(.top, 20)
                
                // Grid of number cards
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(numbers, id: \.self) { number in
                            NumberCard(
                                number: number,
                                color: pastelColors[number - 1],
                                isHighlighted: highlightedNumber == number,
                                isShaking: shakingNumber == number
                            )
                            .onTapGesture {
                                handleNumberTap(number)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                }
            }
            
            // Star burst animation overlay
            if showStarBurst {
                StarBurstView()
                    .position(starBurstPosition)
                    .allowsHitTesting(false)
            }
        }
        .navigationTitle("Numbers 1-10")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            askForNumber()
        }
        .onDisappear {
            GameManager.shared.stopSpeaking()
        }
    }
    
    // MARK: - Game Logic
    
    private func askForNumber() {
        // Small delay before asking
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            targetNumber = Int.random(in: 1...10)
            highlightedNumber = targetNumber
            GameManager.shared.speak("\(targetNumber)")
            
            // Remove highlight after a moment
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    highlightedNumber = nil
                }
            }
        }
    }
    
    private func handleNumberTap(_ number: Int) {
        if number == targetNumber {
            // Correct answer!
            handleCorrectAnswer(number)
        } else {
            // Wrong answer
            handleWrongAnswer(number)
        }
    }
    
    private func handleCorrectAnswer(_ number: Int) {
        // Play success sound
        GameManager.shared.speak("Great job!")
        
        // Add star using StarBank
        starBank.addStars(1)
        
        // Show star burst at card position
        showStarBurst = true
        starBurstPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        
        // Hide star burst after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showStarBurst = false
            
            // Ask for next number
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                askForNumber()
            }
        }
    }
    
    private func handleWrongAnswer(_ number: Int) {
        // Shake the card
        withAnimation(.default.speed(2).repeatCount(3, autoreverses: true)) {
            shakingNumber = number
        }
        
        // Play gentle encouragement
        GameManager.shared.speak("Try again!")
        
        // Stop shaking after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            shakingNumber = nil
        }
    }
}

// MARK: - Number Card

struct NumberCard: View {
    let number: Int
    let color: Color
    let isHighlighted: Bool
    let isShaking: Bool
    
    @State private var scale: CGFloat = 1.0
    @State private var shakeOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // 3D shadow layer
            RoundedRectangle(cornerRadius: 28)
                .fill(color.opacity(0.4))
                .frame(height: 140)
                .offset(y: 6)
                .blur(radius: 4)
            
            // Main card
            RoundedRectangle(cornerRadius: 28)
                .fill(
                    LinearGradient(
                        colors: [
                            color,
                            color.opacity(0.9)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 140)
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
                        .stroke(Color.white.opacity(0.7), lineWidth: 4)
                )
                .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 6)
                .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
            
            // Number text
            Text("\(number)")
                .font(.system(size: 72, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .white,
                            Color.white.opacity(0.9)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: color.opacity(0.8), radius: 0, x: 3, y: 4)
        }
        .scaleEffect(scale)
        .offset(x: shakeOffset)
        .overlay(
            // Highlight ring
            RoundedRectangle(cornerRadius: 28)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.8, blue: 0.2),
                            Color(red: 1.0, green: 0.9, blue: 0.3)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: isHighlighted ? 8 : 0
                )
                .frame(height: 140)
                .shadow(color: Color(red: 1.0, green: 0.9, blue: 0.3), radius: isHighlighted ? 15 : 0)
        )
        .onChange(of: isHighlighted) { _, newValue in
            if newValue {
                withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                    scale = 1.08
                }
            } else {
                withAnimation(.easeOut(duration: 0.3)) {
                    scale = 1.0
                }
            }
        }
        .onChange(of: isShaking) { _, newValue in
            if newValue {
                withAnimation(.default.speed(4).repeatCount(6, autoreverses: true)) {
                    shakeOffset = 10
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    shakeOffset = 0
                }
            }
        }
    }
}

// MARK: - Star Burst Animation

struct StarBurstView: View {
    @State private var animating = false
    
    var body: some View {
        ZStack {
            ForEach(0..<8) { index in
                StarShape()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 1.0, green: 0.9, blue: 0.3),
                                Color(red: 1.0, green: 0.8, blue: 0.2)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(Double(index) * 45))
                    .offset(y: animating ? -120 : 0)
                    .opacity(animating ? 0 : 1)
                    .scaleEffect(animating ? 2.0 : 0.5)
                    .rotationEffect(.degrees(animating ? 360 : 0))
            }
            
            // Center star
            StarShape()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.95, blue: 0.4),
                            Color(red: 1.0, green: 0.85, blue: 0.2)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 80, height: 80)
                .scaleEffect(animating ? 1.5 : 0.5)
                .opacity(animating ? 0 : 1)
                .rotationEffect(.degrees(animating ? 180 : 0))
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animating = true
            }
        }
    }
}

// MARK: - Star Shape

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.4
        let pointCount = 5
        
        for i in 0..<pointCount * 2 {
            let angle = (Double(i) * .pi) / Double(pointCount) - .pi / 2
            let radius = i.isMultiple(of: 2) ? outerRadius : innerRadius
            let x = center.x + CGFloat(cos(angle)) * radius
            let y = center.y + CGFloat(sin(angle)) * radius
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    NavigationStack {
        NumbersView()
    }
}
