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
            .font(.title)
            .foregroundColor(Color(UIColor.systemBackground))
            .frame(width: size, height: size)
            .background(letter.statusColor)
            .cornerRadius(size / 5.0)
    }
}

struct GuessBoxView_Previews: PreviewProvider {
    static var previews: some View {
        let guess = GuessedLetter(letter: "S", status: .inPosition)
        GuessBoxView(letter: guess, size: 50, index: 1)
    }
}
