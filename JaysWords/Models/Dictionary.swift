//
//  Dictionary.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import Foundation

class Dictionary: ObservableObject {
  var wordLength: Int
  @Published var words: [String] = []
  @Published var commonWords: [String] = []

  init(length: Int) {
    wordLength = length

    guard
      let fileUrl = Bundle.main.url(forResource: "words-5", withExtension: "txt"),
      let dictionary = try? String(contentsOf: fileUrl, encoding: .utf8) else {
        return
      }

    for word in dictionary.split(separator: "\n") {
      let newWord = String(word)
      if newWord.count == wordLength {
        words.append(newWord.uppercased())
      }
    }

    guard
      let commonFileUrl = Bundle.main.url(forResource: "common-words-5", withExtension: "txt"),
      let commonDictionary = try? String(contentsOf: commonFileUrl, encoding: .utf8) else {
        return
      }

    for word in commonDictionary.split(separator: "\n") {
      let newWord = String(word)
      if newWord.count == wordLength {
        commonWords.append(newWord.uppercased())
      }
    }
  }

  func isValidWord(_ word: String) -> Bool {
    let casedWord = word.uppercased()
    return words.contains { $0 == casedWord }
  }
}
