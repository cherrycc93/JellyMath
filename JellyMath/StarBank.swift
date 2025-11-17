//
//  StarBank.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI
import Combine

/// Shared model for tracking the child's total stars (coins) across the entire app
@MainActor
class StarBank: ObservableObject {
    @Published var stars: Int {
        didSet {
            // Auto-save whenever stars change
            saveStars()
        }
    }
    
    private let userDefaultsKey = "jellyMathStars"
    
    init() {
        // Load saved stars from persistent storage
        self.stars = UserDefaults.standard.integer(forKey: userDefaultsKey)
        
        // If no saved value exists, start with default 128
        if self.stars == 0 && !UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
            self.stars = 128
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
    }
    
    /// Add stars when completing activities, games, or achievements
    func addStars(_ amount: Int) {
        stars += amount
    }
    
    /// Spend stars on rewards, unlocks, or customizations
    /// Returns true if purchase was successful, false if not enough stars
    @discardableResult
    func spendStars(_ amount: Int) -> Bool {
        guard stars >= amount else {
            return false // Not enough stars
        }
        stars -= amount
        return true
    }
    
    /// Check if the child has enough stars for a purchase
    func canAfford(_ amount: Int) -> Bool {
        return stars >= amount
    }
    
    /// Reset stars to a specific amount (useful for testing or parental controls)
    func resetStars(to amount: Int = 0) {
        stars = amount
    }
    
    /// Save stars to persistent storage
    private func saveStars() {
        UserDefaults.standard.set(stars, forKey: userDefaultsKey)
    }
    
    /// Get formatted string for display (e.g., "128" or "1,234")
    func formattedStars() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: stars)) ?? "\(stars)"
    }
}

// MARK: - Preview Helper

extension StarBank {
    /// Create a preview instance with sample data
    static var preview: StarBank {
        let bank = StarBank()
        bank.stars = 128
        return bank
    }
}
