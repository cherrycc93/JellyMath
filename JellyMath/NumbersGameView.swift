//
//  NumbersGameView.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

// MARK: - Game Question Model

struct CountingQuestion {
    let objectEmoji: String
    let objectName: String
    let correctAnswer: Int
    let options: [Int]
    
    static func random() -> CountingQuestion {
        let objects = [
            ("⭐️", "stars"),
            ("🎈", "balloons"),
            ("🍎", "apples"),
            ("🌸", "flowers"),
            ("🦋", "butterflies"),
            ("🍓", "strawberries"),
            ("🌈", "rainbows"),
            ("🎁", "presents"),
            ("🐠", "fish"),
            ("🍪", "cookies")
        ]
        
        let (emoji, name) = objects.randomElement()!
        let correctAnswer = Int.random(in: 1...10)
        
        // Generate 3 wrong options
        var options = [correctAnswer]
        while options.count < 4 {
            let randomNumber = Int.random(in: 1...10)
            if !options.contains(randomNumber) {
                options.append(randomNumber)
            }
        }
        
        return CountingQuestion(
            objectEmoji: emoji,
            objectName: name,
            correctAnswer: correctAnswer,
            options: options.shuffled()
        )
    }
}

// MARK: - Numbers Game View

struct NumbersGameView: View {
    @EnvironmentObject private var starBank: StarBank
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentQuestion = CountingQuestion.random()
    @State private var selectedAnswer: Int? = nil
    @State private var isCorrect = false
    @State private var showNextButton = false
    @State private var celebrationScale: CGFloat = 1.0
    @State private var questionsAnswered = 0
    
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
            
            VStack(spacing: 30) {
                // Top bar with stars counter and close button
                HStack {
                    // Close button
                    Button(action: {
                        dismiss()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.9))
                                .frame(width: 44, height: 44)
                                .shadow(color: .black.opacity(0.1), radius: 6, y: 3)
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.5))
                        }
                    }
                    
                    Spacer()
                    
                    // Star counter
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
                        
                        Text("\(starBank.stars)")
                            .font(.system(size: 24, weight: .black, design: .rounded))
                            .foregroundColor(.white)
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
                            .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                    )
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                Spacer()
                
                // Question section
                VStack(spacing: 30) {
                    // Question text
                    Text("How many \(currentQuestion.objectName)?")
                        .font(.system(size: 36, weight: .black, design: .rounded))
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
                        .padding(.horizontal, 24)
                    
                    // Objects to count
                    objectsDisplay
                        .scaleEffect(celebrationScale)
                }
                
                Spacer()
                
                // Answer options
                if !showNextButton {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(currentQuestion.options, id: \.self) { option in
                            AnswerButton(
                                number: option,
                                isSelected: selectedAnswer == option,
                                isCorrect: isCorrect && selectedAnswer == option,
                                isWrong: !isCorrect && selectedAnswer == option
                            ) {
                                handleAnswer(option)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                } else {
                    // Next button
                    Button(action: nextQuestion) {
                        HStack(spacing: 12) {
                            Text("Next")
                                .font(.system(size: 32, weight: .black, design: .rounded))
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 28, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.4, green: 0.8, blue: 0.6),
                                            Color(red: 0.3, green: 0.7, blue: 0.5)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: .black.opacity(0.15), radius: 12, y: 8)
                        )
                    }
                    .padding(.horizontal, 24)
                }
                
                Spacer()
            }
            
            // Celebration fox
            if isCorrect && selectedAnswer != nil {
                VStack {
                    FoxMascot(pose: .cheering, size: 120)
                        .scaleEffect(celebrationScale)
                        .offset(y: -50)
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Objects Display
    
    private var objectsDisplay: some View {
        let rows = (currentQuestion.correctAnswer + 4) / 5 // Max 5 per row
        let columns = min(currentQuestion.correctAnswer, 5)
        
        return VStack(spacing: 12) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(0..<itemsInRow(row: row), id: \.self) { col in
                        Text(currentQuestion.objectEmoji)
                            .font(.system(size: 50))
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.white.opacity(0.9))
                .shadow(color: .black.opacity(0.1), radius: 12, y: 6)
        )
    }
    
    private func itemsInRow(row: Int) -> Int {
        let remaining = currentQuestion.correctAnswer - (row * 5)
        return min(remaining, 5)
    }
    
    // MARK: - Game Logic
    
    private func handleAnswer(_ answer: Int) {
        guard selectedAnswer == nil else { return }
        
        selectedAnswer = answer
        isCorrect = answer == currentQuestion.correctAnswer
        
        if isCorrect {
            // Correct answer celebration
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                celebrationScale = 1.2
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    celebrationScale = 1.0
                }
            }
            
            // Add star
            starBank.addStars(1)
            questionsAnswered += 1
            
            // Show next button after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    showNextButton = true
                }
            }
        } else {
            // Wrong answer - shake
            withAnimation(.default.speed(4).repeatCount(3, autoreverses: true)) {
                celebrationScale = 0.95
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                celebrationScale = 1.0
                selectedAnswer = nil
            }
        }
    }
    
    private func nextQuestion() {
        withAnimation {
            selectedAnswer = nil
            isCorrect = false
            showNextButton = false
            celebrationScale = 1.0
            currentQuestion = CountingQuestion.random()
        }
    }
}

// MARK: - Answer Button

struct AnswerButton: View {
    let number: Int
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    var backgroundColor: Color {
        if isCorrect {
            return Color(red: 0.4, green: 0.9, blue: 0.6)
        } else if isWrong {
            return Color(red: 1.0, green: 0.5, blue: 0.5)
        } else {
            return Color(red: 1.0, green: 0.9, blue: 0.7)
        }
    }
    
    var body: some View {
        Button(action: {
            if !isSelected {
                action()
            }
        }) {
            ZStack {
                // Shadow layer
                RoundedRectangle(cornerRadius: 25)
                    .fill(backgroundColor.opacity(0.4))
                    .offset(y: isPressed ? 3 : 8)
                    .blur(radius: 4)
                
                // Main button
                RoundedRectangle(cornerRadius: 25)
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
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
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
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white.opacity(0.7), lineWidth: 4)
                    )
                    .shadow(color: backgroundColor.opacity(0.5), radius: 10, x: 0, y: 6)
                    .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: isPressed ? 4 : 10)
                    .scaleEffect(isPressed ? 0.93 : 1.0)
                    .offset(y: isPressed ? 4 : 0)
                
                // Number text
                Text("\(number)")
                    .font(.system(size: 56, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            }
            .frame(height: 120)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isSelected)
    }
}

#Preview {
    NavigationStack {
        NumbersGameView()
            .environmentObject(StarBank.preview)
    }
}
