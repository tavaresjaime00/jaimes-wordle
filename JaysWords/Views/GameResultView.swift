//
//  GameResultView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct GameResultView: View {
  @ObservedObject var game: GuessingGame

  var body: some View {
      VStack {
          if game.status == .won {
              Text("You got it, superstar!")
                  .font(.title)
                  .foregroundColor(.green)
          } else {
              Text("Sorry, you didn't get it in \(game.maxGuesses) guesses.")
                  .font(.title2)
                  .foregroundColor(.red)
          }
          Text("The word was \(game.targetWord).")
              .font(.title2)
              .foregroundColor(.white)
          ScrollView {
              ShowResultView(game: game)
              StatisticsView(stats: GameStatistics(gameRecord: game.gameRecord))
          }
      }
  }
}

struct GameResultView_Previews: PreviewProvider {
  static var previews: some View {
      Group {
        GameResultView(
          game: GuessingGame.wonGame()
        )
        GameResultView(
          game: GuessingGame.lostGame()
        )
      }

  }
}
