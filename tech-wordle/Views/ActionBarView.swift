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
        Button {
            showStats = true
        } label: {
            Image(systemName: "chart.bar")
                .imageScale(.large)
                .foregroundColor(.gray)
                .accessibilityLabel("Show Statistics")
        }
        Spacer()
        Button {
            game.newGame()
        } label: {
          Text("New Game")
                //.foregroundColor(.white)
                .foregroundColor(.green)
                .accessibilityLabel("New Game")
        }
        .disabled(game.status == .inprogress || game.status == .new)
        .hoverEffect(.lift)
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
