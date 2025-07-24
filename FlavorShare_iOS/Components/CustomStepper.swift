//
//  CustomStepper.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-07.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Int
    var range: ClosedRange<Int>
    var step: Int = 1
    var label: String
    
    // This state variable will directly control the scale effect for the animation
    @State private var minusButtonScale: CGFloat = 1.0
    @State private var plusButtonScale: CGFloat = 1.0
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            
            HStack{
                Button(action: {
                    if value > range.lowerBound {
                        value -= step
                    }
                    
                    // Trigger the animation
                    minusButtonScale = 0.8
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        minusButtonScale = 1.0 // Scale back to normal
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title2)
                        .scaleEffect(minusButtonScale)
                        .animation(.bouncy(duration: 0.3), value: minusButtonScale)
                }
                .disabled(value == range.lowerBound)
                .opacity(value == range.lowerBound ? 0.5 : 1.0)
                
                
                TextField("", value: $value, formatter: NumberFormatter())
                    .frame(width: 50)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)) { _ in
                        if value < range.lowerBound {
                            value = range.lowerBound
                        } else if value > range.upperBound {
                            value = range.upperBound
                        }
                    }
                
                Button(action: {
                    if value < range.upperBound {
                        value += step
                    }
                    
                    // Trigger the animation
                    plusButtonScale = 0.8
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        plusButtonScale = 1.0 // Scale back to normal
                    }
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .scaleEffect(plusButtonScale)
                        .animation(.bouncy(duration: 0.3), value: plusButtonScale)
                }
                .disabled(value == range.upperBound)
                .opacity(value == range.upperBound ? 0.5 : 1.0)
            }
            .glassEffect(.clear)
        }
    }
}

#Preview {
    CustomStepper(value: .constant(1), range: 1...10, label: "Quantity")
}
