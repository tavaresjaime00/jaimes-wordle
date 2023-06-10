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

    let dynamicSize = UIScreen.main.bounds.width / 20
    
    var body: some View {
      HStack {
        Button {
            showStats = true
        } label: {
            Image(systemName: "chart.bar")
                .font(.system(size: dynamicSize * 1.2))
                .foregroundColor(.green)
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
                .font(.system(size: dynamicSize))
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
