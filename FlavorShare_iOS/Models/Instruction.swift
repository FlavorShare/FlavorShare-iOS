//
//  Instruction.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Instruction: Hashable, Encodable {
    var step: Int
    var description: String
    
    init(step: Int, description: String) {
        self.step = step
        self.description = description
    }
}
