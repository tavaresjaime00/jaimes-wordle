//
//  ShowResultView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct ShowResultView: View {
    @State var showShare = false

    var game: GuessingGame
    let yellowBox = "\u{1F7E8}"
    let greenBox = "\u{1F7E9}"
    let grayBox = "\u{2B1B}"

    var body: some View {
        VStack {
            if let text = game.shareResultText {
                Text(text)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .bottomTrailing) {
                        Button {
                            showShare = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 60)
                    }
            } else {
                Text("Game incomplete! Finish up first!")
            }
        }
        .background(.black)
        .foregroundColor(.white)
        .sheet(isPresented: $showShare) {
            let text = game.shareResultText ?? ""
            ActivitySheetView(activityItems: [text])
        }
        .foregroundColor(.white)
        .font(.title3)
        .multilineTextAlignment(.center)
    }
}

struct ShowResultView_Previews: PreviewProvider {
    static var previews: some View {
        ShowResultView(game: GuessingGame.wonGame())
    }
}
