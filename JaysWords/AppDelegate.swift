//
//  AppDelegate.swift
//  JaysWords
//
//  Created by Jaime Tavares on 2023-07-19.
//

import GoogleMobileAds
import UIKit
import Foundation

class AppDelegate: UIResponder, UIApplicationDelegate, GADFullScreenContentDelegate {
    var window: UIWindow?    
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Initialize Google Mobile Ads SDK.
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    // Although the Google Mobile Ads SDK might not be fully initialized at this point,
    // we should still load the app open ad so it becomes ready to show when the splash
    // screen dismisses.
    AppOpenAdManager.shared.loadAd()
    return true
  }

    func applicationDidBecomeActive(_ application: UIApplication) {
        let rootViewController = UIApplication.shared.inputView?.window?.rootViewController
        if let rootViewController = rootViewController {
            if rootViewController.isBeingPresented {
                AppOpenAdManager.shared.showAdIfAvailable(viewController: rootViewController)
            }
            //AppOpenAdManager.shared.showAdIfAvailable(viewController: rootViewController)
        }
    }
}
