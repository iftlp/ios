//
//  AppDelegate.swift
//  Shizima
//
//  Created by Loris Perret on 05/05/2025.
//

import Foundation
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Back Button title
        let backButtonTitleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear
        ] as [NSAttributedString.Key: Any]
        UIBarButtonItem.appearance().setTitleTextAttributes(backButtonTitleAttributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(backButtonTitleAttributes, for: .highlighted)
        
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(R.color.primary)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        let imageSize: CGFloat = 32
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageSize, height: imageSize))
        let customBackImage = renderer.image { context in
            // Dessiner le cercle vert
            let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
            UIColor(R.color.lightGrey).setFill()
            circlePath.fill()

            // Dessiner le chevron noir ou autre couleur personnalisée
            if let chevron = UIImage(systemName: "chevron.left")?.withTintColor(UIColor(R.color.black), renderingMode: .alwaysOriginal) {
                chevron.draw(in: CGRect(x: 10, y: 8, width: 12, height: 15))
            }
        }

        // TRÈS IMPORTANT : rendre l’image finale "originale"
        let finalBackImage = customBackImage.withRenderingMode(.alwaysOriginal)

        UINavigationBar.appearance().backIndicatorImage = finalBackImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = finalBackImage
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(R.color.black)]
        
        return true
    }
}
