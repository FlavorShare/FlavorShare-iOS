//
//  Instruction.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Instruction {
    let step: Int
    let description: String
    
    init(step: Int, description: String) {
        self.step = step
        self.description = description
    }
}
