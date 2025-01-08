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

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Button(action: {
                if value > range.lowerBound {
                    value -= step
                }
            }) {
                Image(systemName: "minus.circle")
            }
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
            }) {
                Image(systemName: "plus.circle")
            }
        }
    }
}

#Preview {
    CustomStepper(value: .constant(1), range: 1...10, label: "Quantity")
}
