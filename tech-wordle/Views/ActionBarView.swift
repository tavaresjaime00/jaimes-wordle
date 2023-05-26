//
//  ActionBarView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct ActionBarView: View {
    @Binding var showStats: Bool
    @ObservedObject var game: GuessingGame

    
    var body: some View {
      HStack {
        Spacer()
        Button {
            game.newGame()
        } label: {
          Text("New Game")
                .accessibilityLabel("New Game").foregroundColor(.white)
        }
        .disabled(game.status == .inprogress || game.status == .new)
      }.padding(7)
    }
  }

  struct ActionBarView_Previews: PreviewProvider {
    static var previews: some View {
      ActionBarView(
        showStats: .constant(false),
        game: GuessingGame.inProgressGame()
      )
    }
  }
