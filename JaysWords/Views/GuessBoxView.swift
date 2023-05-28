//
//  GuessBoxView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct GuessBoxView: View {
    var letter: GuessedLetter
    var size: Double
    var index: Int
    
    var body: some View {
        Text(letter.letter)
            .rotation3DEffect(
                .degrees(letter.status == .unknown ? 0 : -180),
                axis: (x: 0.0, y: 1.0, z: 0.0))
            .font(.title)
            .foregroundColor(Color(UIColor.systemBackground))
            .frame(width: size, height: size)
            .background(letter.statusColor)
            .cornerRadius(size / 5.0)
            .rotation3DEffect(
              .degrees(letter.status == .unknown ? 0 : 180),
              axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(
                .linear(duration: 1.0).delay(0.1 * Double(index)),
                value: letter.status
            )
    }
}

struct GuessBoxView_Previews: PreviewProvider {
    static var previews: some View {
        let guess = GuessedLetter(letter: "S", status: .inPosition)
        GuessBoxView(letter: guess, size: 50, index: 1)
    }
}
