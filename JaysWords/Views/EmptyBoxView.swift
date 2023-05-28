//
//  EmptyBoxView.swift
//  tech-wordle
//
//  Created by Jaime Tavares on 2023-05-25.
//

import SwiftUI

struct EmptyBoxView: View {
  var size: Double

  var body: some View {
    RoundedRectangle(cornerRadius: size / 5.0)
          .stroke(Color(UIColor.green))
      .frame(width: size, height: size)
  }
}

struct EmptyBoxView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyBoxView(size: 50.0)
  }
}
