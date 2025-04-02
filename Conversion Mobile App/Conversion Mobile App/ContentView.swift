//
//  ContentView.swift
//  Conversion Mobile App
//
//  Created by Admin on 4/2/25.
//

import SwiftUI

struct ContentView: View {
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
        } else if let value = Double(secondInput) {
            let convertedValue = convert(value: value, from: secondUnit, to: firstUnit)
            firstInput = String(format: "%.4f", convertedValue)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // First input field with unit selection
            VStack {
                TextField("Enter value", text: $firstInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: firstInput) { _ in
                        updateConversion()
                    }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(units, id: \.self) { unit in
                            Button(action: {
                                firstUnit = unit
                                updateConversion()
                            }) {
                                Text(unit)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(firstUnit == unit ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(firstUnit == unit ? .white : .primary)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // Second input field with unit selection
            VStack {
                TextField("Converted value", text: $secondInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: secondInput) { _ in
                        updateConversion()
                    }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(units, id: \.self) { unit in
                            Button(action: {
                                secondUnit = unit
                                updateConversion()
                            }) {
                                Text(unit)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(secondUnit == unit ? Color.blue : .blue.opacity(0.2))
                                    .foregroundColor(secondUnit == unit ? .white : .primary)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
