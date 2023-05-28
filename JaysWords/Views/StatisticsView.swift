//
//  StatisticsView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct StatisticsView: View {
    var stats: GameStatistics
    var body: some View {
        VStack {
            VStack(spacing: 75.0) {
                VStack(spacing: 25.0) {
                    Text("Game Statistics")
                        .font(.title)
                    Text("Played: \(stats.gamesPlayed)  ") +
                    Text("Won: \(stats.gamesWon) (\(stats.percentageWon) %) ") +
                    Text("Win Streak: \(stats.currentWinStreak)  ") +
                    Text("Max Streak: \(stats.maxWinStreak)  ")
                }
                VStack(alignment: .leading) {
                    Text("Winning Guess Distribution")
                        .font(.title)
                    
                    let maxDistribution = Double(stats.winRound.max() ?? 1)
                    ForEach(stats.winRound.indices, id: \.self) { index in
                        let barCount = stats.winRound[index]
                        let barLength = barCount > 0 ? Double(barCount) / maxDistribution * 250.0 : 1
                        HStack {
                            Text("\(index + 1):")
                            Rectangle()
                                .frame(width: barLength, height: 20.0)
                            Text("\(barCount)")
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 70.0)
        .padding(.vertical, 200.0)
        .background(.black)
        .foregroundColor(.white)
    }
}



struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stats: GameStatistics(gameRecord: ""))
    }
}
