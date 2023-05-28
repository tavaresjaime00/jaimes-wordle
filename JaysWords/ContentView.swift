//
//  ContentView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @StateObject var game = GuessingGame()
    @State private var showStats = false
    @State private var showResults = false

    var body: some View {
        VStack {
            Text("Jay's Words")
                .font(.title)
                .accessibilityAddTraits(.isHeader)
                .foregroundColor(.green)
            GameBoardView(game: game)
            KeyboardView(game: game)
                .padding(5)
            ActionBarView(showStats: $showStats, game: game)
        }
        .sheet(isPresented: $showResults) {
            GameResultView(game: game).background(.black)
        }
        .sheet(isPresented: $showStats) {
            StatisticsView(stats: GameStatistics(gameRecord: game.gameRecord)).background(.black)
        }
        .onChange(of: game.status) { newStatus in
            if newStatus == .won || newStatus == .lost {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showResults = true
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if game.status == .new && !game.gameState.isEmpty {
                    game.loadState()
                }
            }
            if newPhase == .background || newPhase == .inactive {
                game.saveState()
            }
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
