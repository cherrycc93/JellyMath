//
//  GameManager.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI
import Combine
import AVFoundation

/// Global game state manager for tracking stars and progress
@MainActor
class GameManager: ObservableObject {
    static let shared = GameManager()
    
    @Published var totalStars: Int = 0
    
    private let synthesizer = AVSpeechSynthesizer()
    
    private init() {
        // Load saved stars
        totalStars = UserDefaults.standard.integer(forKey: "totalStars")
    }
    
    func addStar() {
        totalStars += 1
        UserDefaults.standard.set(totalStars, forKey: "totalStars")
    }
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.45 // Slower for kids
        utterance.pitchMultiplier = 1.2 // Slightly higher pitch
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
