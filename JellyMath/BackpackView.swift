import SwiftUI

// MARK: - Model
struct BackpackItem: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let iconName: String
    let cost: Int
    var isOwned: Bool = false
}

// MARK: - Backpack View
struct BackpackView: View {
    @EnvironmentObject private var starBank: StarBank
    @State private var items: [BackpackItem] = [
        BackpackItem(name: "Fox Hat", iconName: "pawprint.fill", cost: 40),
        BackpackItem(name: "Rainbow Trail", iconName: "rainbow", cost: 60),
        BackpackItem(name: "Magic Wand", iconName: "wand.and.stars", cost: 75),
        BackpackItem(name: "Sparkle Shoes", iconName: "shoeprints.fill", cost: 50),
        BackpackItem(name: "Comfy Cape", iconName: "scarf.fill", cost: 90),
        BackpackItem(name: "Balloon Buddy", iconName: "balloon.2.fill", cost: 35)
    ]
    @State private var notEnoughStarsFor: UUID? = nil

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            // Background
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

            VStack(spacing: 0) {
                // Header with fox and star balance
                header
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(items.indices, id: \.self) { index in
                            JellyBackpackItemCard(
                                item: items[index],
                                canAfford: starBank.canAfford(items[index].cost),
                                isShaking: notEnoughStarsFor == items[index].id,
                                buyAction: { handleBuy(at: index) }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)

                    Spacer(minLength: 10)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews
    private var header: some View {
        HStack(alignment: .center, spacing: 16) {
            // Fox mascot
            FoxMascot(pose: .waving, size: 80)
                .padding(.leading, 4)

            VStack(alignment: .leading, spacing: 6) {
                Text("Backpack")
                    .font(.system(size: 28, weight: .black, design: .rounded))
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

                // Star balance pill
                HStack(spacing: 10) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 24, weight: .bold))
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

                    Text(starBank.formattedStars())
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.45))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.95))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.5), Color.white.opacity(0.0)],
                                        startPoint: .topLeading,
                                        endPoint: .center
                                    )
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
                )
            }

            Spacer()
        }
    }

    // MARK: - Actions
    private func handleBuy(at index: Int) {
        guard items.indices.contains(index) else { return }
        if items[index].isOwned { return }

        let cost = items[index].cost
        if starBank.spendStars(cost) {
            // Mark as owned
            items[index].isOwned = true
        } else {
            // Trigger a short shake animation for this card
            let id = items[index].id
            notEnoughStarsFor = id
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                if notEnoughStarsFor == id { notEnoughStarsFor = nil }
            }
        }
    }
}

// MARK: - Item Card
struct JellyBackpackItemCard: View {
    let item: BackpackItem
    let canAfford: Bool
    let isShaking: Bool
    let buyAction: () -> Void

    @State private var isPressed: Bool = false
    @State private var shake: CGFloat = 0

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isPressed = false
            }
            buyAction()
        }) {
            VStack(spacing: 12) {
                ZStack {
                    // Shadow layer for icon circle
                    Circle()
                        .fill(cardAccent.opacity(0.35))
                        .frame(width: 70, height: 70)
                        .offset(y: isPressed ? 2 : 6)
                        .blur(radius: 4)

                    // Icon circle
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [cardAccent, cardAccent.opacity(0.85)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 70, height: 70)
                        .overlay(
                            Circle().fill(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.6), Color.white.opacity(0.0)],
                                    startPoint: .topLeading,
                                    endPoint: .center
                                )
                            )
                        )
                        .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 3))
                        .shadow(color: cardAccent.opacity(0.5), radius: 8, x: 0, y: 5)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: isPressed ? 3 : 7)
                        .scaleEffect(isPressed ? 0.95 : 1.0)
                        .offset(y: isPressed ? 3 : 0)

                    // Icon
                    Image(systemName: item.iconName)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                }

                // Name
                Text(item.name)
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.45))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)

                // Cost / Owned
                if item.isOwned {
                    ownedBadge
                } else {
                    costRow
                }

                // Buy button (or Owned)
                buyButton
            }
            .padding(16)
            .background(cardBackground)
            .overlay(cardGloss)
            .overlay(cardBorder)
            .modifier(ShakeEffect(animatableData: isShaking ? 1 : 0))
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Components
    private var cardAccent: Color {
        // Choose a soft accent color based on name hash for variety
        let colors: [Color] = [
            Color(red: 1.0, green: 0.7, blue: 0.8),   // Pink
            Color(red: 0.7, green: 0.85, blue: 1.0),  // Blue
            Color(red: 1.0, green: 0.9, blue: 0.6),   // Yellow
            Color(red: 0.8, green: 1.0, blue: 0.8),   // Green
            Color(red: 1.0, green: 0.85, blue: 0.9),  // Rose
            Color(red: 0.9, green: 0.8, blue: 1.0)    // Lavender
        ]
        let idx = abs(item.name.hashValue) % colors.count
        return colors[idx]
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(
                LinearGradient(
                    colors: [Color.white.opacity(0.98), Color.white.opacity(0.92)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 8)
    }

    private var cardGloss: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(
                LinearGradient(
                    colors: [Color.white.opacity(0.55), Color.white.opacity(0.0)],
                    startPoint: .topLeading,
                    endPoint: .center
                )
            )
            .padding(0.0)
            .allowsHitTesting(false)
    }

    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: 24)
            .stroke(Color.white, lineWidth: 4)
            .allowsHitTesting(false)
    }

    private var costRow: some View {
        HStack(spacing: 6) {
            Image(systemName: "star.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(canAfford ? Color(red: 1.0, green: 0.8, blue: 0.2) : Color(red: 0.6, green: 0.6, blue: 0.65))
            Text("\(item.cost)")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(canAfford ? Color(red: 1.0, green: 0.8, blue: 0.2) : Color(red: 0.6, green: 0.6, blue: 0.65))
        }
    }

    private var ownedBadge: some View {
        Text("Owned")
            .font(.system(size: 13, weight: .black, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.green.opacity(0.9), Color.green.opacity(0.75)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(Capsule().stroke(Color.white.opacity(0.8), lineWidth: 2))
                    .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 4)
            )
    }

    private var buyButton: some View {
        Group {
            if item.isOwned {
                Text("Owned")
                    .font(.system(size: 15, weight: .heavy, design: .rounded))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [Color.green.opacity(0.9), Color.green.opacity(0.75)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.white.opacity(0.8), lineWidth: 2)
                            )
                    )
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 5)
            } else {
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                    Text(canAfford ? "Buy" : "Buy")
                        .font(.system(size: 15, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            LinearGradient(
                                colors: canAfford
                                    ? [Color(red: 1.0, green: 0.75, blue: 0.35), Color(red: 1.0, green: 0.65, blue: 0.3)]
                                    : [Color(red: 0.75, green: 0.75, blue: 0.8), Color(red: 0.7, green: 0.7, blue: 0.75)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.white.opacity(0.8), lineWidth: 2)
                        )
                )
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 5)
            }
        }
    }
}

// MARK: - Shake Effect for Not Enough Stars
struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 8
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = amount * sin(animatableData * .pi * CGFloat(shakesPerUnit))
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}

#Preview {
    NavigationStack {
        BackpackView()
            .environmentObject(StarBank.preview)
    }
}
