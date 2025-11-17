//
//  ContentView.swift
//  JellyMath
//
//  Created by Chao Chen on 11/17/25.
//

import SwiftUI

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    @State private var displayValue = "0"
    @State private var currentNumber: Double = 0
    @State private var previousNumber: Double = 0
    @State private var operation: Operation = .none
    @State private var isNewNumber = true

    var body: some View {
        VStack(spacing: 12) {
            Spacer()

            // Display
            Text(displayValue)
                .font(.system(size: 64, weight: .light))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            // Calculator buttons
            VStack(spacing: 12) {
                // Row 1: Clear button
                HStack(spacing: 12) {
                    Button(action: { clear() }) {
                        Text("C")
                            .font(.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(height: 80)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                }

                // Row 2: 7, 8, 9, ÷
                HStack(spacing: 12) {
                    numberButton("7")
                    numberButton("8")
                    numberButton("9")
                    operationButton("÷", .divide)
                }

                // Row 3: 4, 5, 6, ×
                HStack(spacing: 12) {
                    numberButton("4")
                    numberButton("5")
                    numberButton("6")
                    operationButton("×", .multiply)
                }

                // Row 4: 1, 2, 3, -
                HStack(spacing: 12) {
                    numberButton("1")
                    numberButton("2")
                    numberButton("3")
                    operationButton("-", .subtract)
                }

                // Row 5: 0, =, +
                HStack(spacing: 12) {
                    numberButton("0")
                        .frame(maxWidth: .infinity)
                    Button(action: { equals() }) {
                        Text("=")
                            .font(.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(height: 80)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    operationButton("+", .add)
                }
            }
            .padding()
        }
        .background(Color.black)
    }

    // Helper function to create number buttons
    func numberButton(_ number: String) -> some View {
        Button(action: { numberPressed(number) }) {
            Text(number)
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 80)
        .background(Color(white: 0.2))
        .foregroundColor(.white)
        .cornerRadius(40)
    }

    // Helper function to create operation buttons
    func operationButton(_ symbol: String, _ op: Operation) -> some View {
        Button(action: { operationPressed(op) }) {
            Text(symbol)
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 80)
        .background(Color.orange)
        .foregroundColor(.white)
        .cornerRadius(40)
    }

    // Number button handler
    func numberPressed(_ number: String) {
        if isNewNumber {
            displayValue = number
            isNewNumber = false
        } else {
            displayValue += number
        }
        currentNumber = Double(displayValue) ?? 0
    }

    // Operation button handler
    func operationPressed(_ op: Operation) {
        if operation != .none && !isNewNumber {
            equals()
        }
        operation = op
        previousNumber = currentNumber
        isNewNumber = true
    }

    // Equals button handler
    func equals() {
        var result: Double = 0

        switch operation {
        case .add:
            result = previousNumber + currentNumber
        case .subtract:
            result = previousNumber - currentNumber
        case .multiply:
            result = previousNumber * currentNumber
        case .divide:
            if currentNumber != 0 {
                result = previousNumber / currentNumber
            } else {
                displayValue = "Error"
                operation = .none
                isNewNumber = true
                return
            }
        case .none:
            return
        }

        // Format the result to remove unnecessary decimal places
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            displayValue = String(format: "%.0f", result)
        } else {
            displayValue = String(result)
        }

        currentNumber = result
        operation = .none
        isNewNumber = true
    }

    // Clear button handler
    func clear() {
        displayValue = "0"
        currentNumber = 0
        previousNumber = 0
        operation = .none
        isNewNumber = true
    }
}

#Preview {
    ContentView()
}
