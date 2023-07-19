//
//  AdViewControllerRepresentable.swift
//  JaysWords
//
//  Created by Jaime Tavares on 2023-07-19.
//

import SwiftUI
import GoogleMobileAds

struct AdViewControllerRepresentable: UIViewControllerRepresentable {
  let viewController = UIViewController()

  func makeUIViewController(context: Context) -> some UIViewController {
    return viewController
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    // No implementation needed. Nothing to update.
  }
}
