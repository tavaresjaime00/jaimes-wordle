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
    @ScaledMetric var dynamicSize: CGFloat = 2

  var body: some View {
    Button {
        game.addKey(letter: key)
    } label: {
      switch key {
      case "<":
          Image(systemName: "delete.backward")
              .aspectRatio(dynamicSize*2, contentMode: .fill)
              .foregroundColor(.red).opacity(0.9)
              .frame(maxWidth: .infinity)

      case ">":
          Image(systemName: "return")
              .aspectRatio(dynamicSize*2, contentMode: .fill)
              .foregroundColor(.green)
              .frame(maxWidth: .infinity)
      default:
        Text(key)
          .aspectRatio(dynamicSize*2, contentMode: .fill)
          .frame(maxWidth: .infinity)
          .foregroundColor(.white)
           
      }
    }
    .padding(dynamicSize*2)
    .background {
      RoundedRectangle(cornerRadius: 6.0)
        .stroke()
    }
    .background(game.colorForKey(key: key))
    .foregroundColor(Color(.white))
    .font(.system(size: UIScreen.main.bounds.width/15                                                                                                                                                         ))
    
  }
}

struct KeyButtonView_Previews: PreviewProvider {
  static var previews: some View {
    let game = GuessingGame()
    Group {
      KeyButtonView(game: game, key: "s")
    }
  }
}
