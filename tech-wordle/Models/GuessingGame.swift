//
//  GuessingGame.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import Foundation
import SwiftUI


enum GameState {
    case initializing
    case new
    case inprogress
    case won
    case lost
}

class GuessingGame: ObservableObject {
    
    @AppStorage("GameRecord") var gameRecord = ""
    @AppStorage("GameState") var gameState = ""
    
    let wordLength = 5
    let maxGuesses = 6
    
    var dictionary: Dictionary
    var status: GameState = .initializing {
        didSet {
            if status == .lost || status == .won {
                gameState = ""
            }
        }
    }
    
    @Published var targetWord: String
    @Published var currentGuess = 0
    @Published var guesses: [Guess]
    
    
    init() {
        dictionary = Dictionary(length: wordLength)
        
        let totalWords = dictionary.commonWords.count
        let randomWord = Int.random(in: 0..<totalWords)
        let word = dictionary.commonWords[randomWord]
        
        targetWord = word
        #if DEBUG
        print("selected word: \(word)")
        #endif
        
        guesses = .init()
        guesses.append(Guess())
        status = .new
    }
    
    func addKey(letter: String) {
        if status == .new {
            status = .inprogress
        }
        guard status == .inprogress else {
            return
        }
        
        switch letter {
        case "<":
            deleteLetter()
        case ">":
            checkGuess()
        default:
            if guesses[currentGuess].word.count < wordLength {
                let newLetter = GuessedLetter(letter : letter)
                guesses[currentGuess].word.append(newLetter)
            }
        }
    }
    
    func deleteLetter() {
        let currentLetters = guesses[currentGuess].word.count
        guard currentLetters > 0 else { return }
        guesses[currentGuess].word.remove(at: currentLetters - 1)
    }
    
    func checkGuess() {
        guard guesses[currentGuess].word.count == wordLength else { return }
        
        if !dictionary.isValidWord(guesses[currentGuess].letters) {
            guesses[currentGuess].status = .invalidWord
            return
        }
        guesses[currentGuess].status = .complete
        
        var targetLettersRemaining = Array(targetWord)
        
        for index in guesses[currentGuess].word.indices {
            let stringIndex = targetWord.index(targetWord.startIndex, offsetBy: index)
            let letterAtIndex = String(targetWord[stringIndex])
            
            if letterAtIndex == guesses[currentGuess].word[index].letter {
                guesses[currentGuess].word[index].status = .inPosition
                
                if let letterIndex = targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
                    targetLettersRemaining.remove(at: letterIndex)
                }
            }
        }
        
        for index in guesses[currentGuess].word.indices
            .filter({ guesses[currentGuess].word[$0].status == .unknown}) {
            let letterAtIndex = guesses[currentGuess].word[index].letter
            var letterStatus = LetterStatus.notInWord
            if targetWord.contains(letterAtIndex) {
                if let guessedLetterIndex = targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
                    letterStatus = .notInPosition
                    targetLettersRemaining.remove(at: guessedLetterIndex)
                }
            }
            guesses[currentGuess].word[index].status = letterStatus
        }
        if targetWord == guesses[currentGuess].letters {
            status = .won
            gameRecord += "\(currentGuess + 1)"
            return
        }
        if currentGuess < maxGuesses - 1 {
            guesses.append(Guess())
            currentGuess += 1
        } else {
            status = .lost
            gameRecord +=  "L"
        }
    }
    
    func newGame() {
        let totalWords = dictionary.commonWords.count
        let randomWord = Int.random(in: 0..<totalWords)
        targetWord = dictionary.commonWords[randomWord]
        print("Selected word: \(targetWord)")
        
        currentGuess = 0
        guesses = []
        guesses.append(Guess())
        status = .new
    }
    
    func statusForLetter(letter: String) -> LetterStatus {
        if letter == "<" || letter == ">" {
            return .unknown
        }
        
        let finishedGuesses = guesses.filter { $0.status == .complete }
        
        let guessedLetters = finishedGuesses.reduce([LetterStatus]()) { partialResult, guess in
            let guessStatuses = guess.word.filter { $0.letter == letter }.map { $0.status }
            
            var currentStatuses = partialResult
            currentStatuses.append(contentsOf: guessStatuses)
            return currentStatuses
            
        }
        
        if guessedLetters.contains(.inPosition) {
            return .inPosition
        }
        if guessedLetters.contains(.notInPosition) {
            return .notInPosition
        }
        if guessedLetters.contains(.notInWord) {
            return .notInWord
        }
        
        return .unknown
    }
    
    func colorForKey(key: String) -> Color {
        let status = statusForLetter(letter: key)
        
        switch status {
        case .unknown:
            return Color(UIColor.darkGray)
        case .inPosition:
            return Color.green
        case .notInPosition:
            return Color.yellow
        case .notInWord:
            return Color.gray.opacity(0.67)
        }
    }
    
    var shareResultText: String? {
        guard status == .won || status == .lost else { return nil }
        
        let yellowBox = "\u{1F7E8}"
        let greenBox = "\u{1F7E9}"
        let grayBox = "\u{2B1B}"
        
        var text = "Jaime\'s Words\n"
        if status == .won {
            text += "Turn \(currentGuess + 1)/\(maxGuesses)\n"
        } else {
            text += "Turn X\(maxGuesses)\n"
        }
        
        var statusString = ""
        for guess in guesses {
            var nextStatus = ""
            for guessedLetter in guess.word {
                switch guessedLetter.status {
                case .inPosition:
                    nextStatus += greenBox
                case .notInPosition:
                    nextStatus += yellowBox
                default:
                    nextStatus += grayBox
                }
                nextStatus += " "
            }
            statusString += nextStatus + "\n"
        }
        return text + statusString
    }
    
    func saveState() {
        let guessList = guesses.map { $0.status == .complete ? "\($0.letters)>" : $0.letters }
        let guessedKeys = guessList.joined()
        gameState = "\(targetWord)|\(guessedKeys)"
        print("Saving current game state: \(gameState)")
    }
    
    func loadState() {
        print("Loading game state: \(gameState)")
        currentGuess = 0
        guesses = .init()
        guesses.append(Guess())
        status = .inprogress
        
        let stateParts = gameState.split(separator: "|")
        targetWord = String(stateParts[0])
        guard stateParts.count > 1 else { return }
        let guessList = String(stateParts[1])
        let letters = Array(guessList)
        for letter in letters {
            let newGuess = String(letter)
            addKey(letter: newGuess)
        }
    }
    
}




 extension GuessingGame {
  convenience init(word: String) {
    self.init()
    self.targetWord = word
  }

  static func inProgressGame() -> GuessingGame {
    let game = GuessingGame(word: "SMILE")
    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    return game
  }

  static func wonGame() -> GuessingGame {
    let game = GuessingGame(word: "SMILE")
    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    return game
  }

  static func lostGame() -> GuessingGame {
    let game = GuessingGame(word: "SMILE")

    game.addKey(letter: "P")
    game.addKey(letter: "I")
    game.addKey(letter: "A")
    game.addKey(letter: "N")
    game.addKey(letter: "O")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "P")
    game.addKey(letter: "O")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "A")
    game.addKey(letter: "R")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "M")
    game.addKey(letter: "E")
    game.addKey(letter: "L")
    game.addKey(letter: "L")
    game.addKey(letter: ">")

    return game
  }

 static func complexGame() -> GuessingGame {
   let game = GuessingGame(word: "THEME")

   game.addKey(letter: "E")
   game.addKey(letter: "E")
   game.addKey(letter: "R")
   game.addKey(letter: "I")
   game.addKey(letter: "E")
   game.addKey(letter: ">")

   game.addKey(letter: "S")
   game.addKey(letter: "T")
   game.addKey(letter: "E")
   game.addKey(letter: "E")
   game.addKey(letter: "L")
   game.addKey(letter: ">")

   game.addKey(letter: "T")
   game.addKey(letter: "H")
   game.addKey(letter: "E")
   game.addKey(letter: "M")
   game.addKey(letter: "E")
   game.addKey(letter: ">")

   return game
  }
 }
