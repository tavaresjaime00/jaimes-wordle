//
//  KeyButtonView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct KeyButtonView: View {
  @ObservedObject var game: GuessingGame
  var key: String

  var body: some View {
    Button {
        game.addKey(letter: key)
    } label: {
      switch key {
      case "<":
          Image(systemName: "delete.backward").foregroundColor(.red).opacity(0.9)
      case ">":
          Image(systemName: "return").foregroundColor(.green)
      default:
        Text(key)
          .aspectRatio(1.0, contentMode: .fit)
          .frame(maxWidth: .infinity).foregroundColor(.white)
      }
    }
    .padding(6)
    .background {
      RoundedRectangle(cornerRadius: 6.0)
        .stroke()
    }
    .foregroundColor(Color(.white))
  }
}

struct KeyButtonView_Previews: PreviewProvider {
  static var previews: some View {
    let game = GuessingGame()
    Group {
      KeyButtonView(game: game, key: "<")
    }
  }
}
