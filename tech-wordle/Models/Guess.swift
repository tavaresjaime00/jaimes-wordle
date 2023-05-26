//
//  Guess.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import Foundation

enum GuessStatus {
    case pending
    case complete
    case invalidWord
}

struct Guess: Identifiable {
    
    var id = UUID()
    
    var word: [GuessedLetter] = []
    var status: GuessStatus = .pending
    
    var letters: String {
        return word.reduce("") {partialResult, nextLetter in
            partialResult.appending(nextLetter.letter)
        }
    }
}
