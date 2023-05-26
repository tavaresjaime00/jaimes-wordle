//
//  ContentView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct ContentView: View {
  @StateObject var game = GuessingGame()
  @State private var showStats = false

  var body: some View {
    VStack {
      Text("Jaime's Words")
            .font(.title)
            .accessibilityAddTraits(.isHeader)
            .foregroundColor(.green)
      GameBoardView(game: game)
      KeyboardView(game: game)
        .padding(5)
        ActionBarView(showStats: $showStats, game: game)
    }
    .frame(alignment: .top)
    .padding([.bottom], 10)
    .background(.black)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
