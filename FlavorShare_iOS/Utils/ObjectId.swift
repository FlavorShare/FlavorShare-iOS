//
//  ObjectId.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-06.
//

import Foundation

class ObjectId {
    private init() {}
    static let shared = ObjectId()

    private var counter = Int.random(in: 0...0xffffff)

    private func incrementCounter() {
        if (counter >= 0xffffff) {
            counter = 0
        } else {
            counter += 1
        }
    }

    func generate() -> String {
        let time = ~(~Int(NSDate().timeIntervalSince1970))
        let random = Int.random(in: 0...0xffffffffff)
        let i = counter
        incrementCounter()

        var byteArray = Array<UInt8>.init(repeating: 0, count: 12)

        byteArray[0] = UInt8((time >> 24) & 0xff)
        byteArray[1] = UInt8((time >> 16) & 0xff)
        byteArray[2] = UInt8((time >> 8) & 0xff)
        byteArray[3] = UInt8(time & 0xff)
        byteArray[4] = UInt8((random >> 32) & 0xff)
        byteArray[5] = UInt8((random >> 24) & 0xff)
        byteArray[6] = UInt8((random >> 16) & 0xff)
        byteArray[7] = UInt8((random >> 8) & 0xff)
        byteArray[8] = UInt8(random & 0xff)
        byteArray[9] = UInt8((i >> 16) & 0xff)
        byteArray[10] = UInt8((i >> 8) & 0xff)
        byteArray[11] = UInt8(i & 0xff)

        let id = byteArray
                     .map({ String($0, radix: 16, uppercase: false)
                     .padding(toLength: 2, withPad: "0", startingAt: 0) })
                     .joined()

        return id
    }
}
