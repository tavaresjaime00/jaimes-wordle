//
//  SwiftUIView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject var game: GuessingGame
    @State var showResult = false
    
    var unusedGuesses: Int {
        let remainingGuesses = game.maxGuesses - game.guesses.count
        if remainingGuesses < 0 {
            return 0
        }
        return remainingGuesses
    }
    
    var body: some View {
        VStack {
            ForEach($game.guesses) { guess in
                CurrentGuessView(guess: guess, wordLength: game.wordLength)
            }
            .padding(.bottom, 10)
            ForEach(0..<unusedGuesses, id: \.self) { _ in
                CurrentGuessView(guess: .constant(Guess()), wordLength: game.wordLength)
            }
            .padding(.bottom)
        }
      
    }
}

struct GameBoardView_Previews: PreviewProvider {
  static var previews: some View {
      GameBoardView(game: GuessingGame.inProgressGame())
  }
}
