//
//  GuessedLetter.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import Foundation
import SwiftUI


struct GuessedLetter {
    var id = UUID()
    var letter: String
    var status: LetterStatus = .unknown
    var statusColor: Color {
        switch status {
            case .unknown:
                return .primary
                
            case .notInWord:
                return .gray
                
            case .notInPosition:
                return .yellow
                
            case .inPosition:
                return .green
        }
    }
}

enum LetterStatus: String {
    case unknown = "Unknown"
    case notInWord = "Not in Word"
    case notInPosition = "In Word, but not this Position"
    case inPosition = "Correct and In Position"
}
