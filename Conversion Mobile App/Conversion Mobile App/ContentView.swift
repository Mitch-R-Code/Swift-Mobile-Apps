//
//  ContentView.swift
//  Conversion Mobile App
//
//  Created by Admin on 4/2/25.
//

import SwiftUI

struct NumberInputView: View {
    @Binding var text: String
    @State private var showNumberPad = false
    
    var body: some View {
        VStack {
            // Input field
            TextField("Enter value", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onTapGesture {
                    showNumberPad = true
                }
            
            // Custom number pad
            if showNumberPad {
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        ForEach(1...3, id: \.self) { number in
                            NumberButton(number: String(number), text: $text)
                        }
                    }
                    HStack(spacing: 10) {
                        ForEach(4...6, id: \.self) { number in
                            NumberButton(number: String(number), text: $text)
                        }
                    }
                    HStack(spacing: 10) {
                        ForEach(7...9, id: \.self) { number in
                            NumberButton(number: String(number), text: $text)
                        }
                    }
                    HStack(spacing: 10) {
                        NumberButton(number: ".", text: $text)
                        NumberButton(number: "0", text: $text)
                        Button(action: {
                            if !text.isEmpty {
                                text.removeLast()
                            }
                        }) {
                            Image(systemName: "delete.left")
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
}

struct NumberButton: View {
    let number: String
    @Binding var text: String
    
    var body: some View {
        Button(action: {
            text += number
        }) {
            Text(number)
                .font(.title)
                .frame(width: 60, height: 60)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

struct ConverterView: View {
    @State private var firstInput: String = ""
    @State private var secondInput: String = ""
    @State private var firstUnit: String = "millimeter"
    @State private var secondUnit: String = "millimeter"
    
    let units = ["millimeter", "centimeter", "meter", "inches", "feet", "yards"]
    
    private func convert(value: Double, from: String, to: String) -> Double {
        // Convert everything to millimeters first
        let valueInMillimeters: Double
        switch from {
        case "millimeter":
            valueInMillimeters = value
        case "centimeter":
            valueInMillimeters = value * 10
        case "meter":
            valueInMillimeters = value * 1000
        case "inches":
            valueInMillimeters = value * 25.4
        case "feet":
            valueInMillimeters = value * 304.8
        case "yards":
            valueInMillimeters = value * 914.4
        default:
            valueInMillimeters = value
        }
        
        // Convert from millimeters to target unit
        switch to {
        case "millimeter":
            return valueInMillimeters
        case "centimeter":
            return valueInMillimeters / 10
        case "meter":
            return valueInMillimeters / 1000
        case "inches":
            return valueInMillimeters / 25.4
        case "feet":
            return valueInMillimeters / 304.8
        case "yards":
            return valueInMillimeters / 914.4
        default:
            return valueInMillimeters
        }
    }
    
    private func updateConversion() {
        if let value = Double(firstInput) {
            let convertedValue = convert(value: value, from: firstUnit, to: secondUnit)
            secondInput = String(format: "%.4f", convertedValue)
        } else {
            secondInput = ""
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with ruler icon
            VStack(spacing: 10) {
                Image(systemName: "ruler")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                Text("Unit Converter")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 20)
            
            // First input field with unit selection
            VStack {
                NumberInputView(text: $firstInput)
                    .onChange(of: firstInput) { _ in
                        updateConversion()
                    }
                
                Picker("From Unit", selection: $firstUnit) {
                    ForEach(units, id: \.self) { unit in
                        Text(unit.capitalized).tag(unit)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: firstUnit) { _ in
                    updateConversion()
                }
            }
            
            // Second display field with unit selection
            VStack {
                Text(secondInput.isEmpty ? "0.0000" : secondInput)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Picker("To Unit", selection: $secondUnit) {
                    ForEach(units, id: \.self) { unit in
                        Text(unit.capitalized).tag(unit)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: secondUnit) { _ in
                    updateConversion()
                }
            }
        }
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            ConverterView()
                .tabItem {
                    Label("Converter", systemImage: "ruler")
                }
            
            DedicationView()
                .tabItem {
                    Label("Dedication", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
