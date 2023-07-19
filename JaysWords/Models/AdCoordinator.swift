//
//  AdCoordinator.swift
//  JaysWords
//
//  Created by Jaime Tavares on 2023-07-19.
//

import UIKit
import GoogleMobileAds

class AdCoordinator: NSObject, GADFullScreenContentDelegate {

    private var ad: GADInterstitialAd?
    // test ad ---     ca-app-pub-3940256099942544/4411468910
    // MY   ad ---     ca-app-pub-6733494635071346/6946554553
    func loadAd() {
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-6733494635071346/6946554553", request: GADRequest()) { ad, error in
            if let error = error {
                return print("Failed to load ad with error: \(error.localizedDescription)")
            }
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
        }
    }
    
    func presentAd(from viewController: UIViewController) {
        guard let fullscreenad = ad else {
            return print("Ad wasn't ready")
        }
        fullscreenad.present(fromRootViewController: viewController)
    }
    
    // MARK: - GADFullScreenContentDelegate methods

    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
      print("\(#function) called")
    }

    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
      print("\(#function) called")
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("\(#function) called")
    }

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("\(#function) called")
    }


    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("\(#function) called")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("\(#function) called")
    }
}
