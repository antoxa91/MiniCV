//
//  AppDelegate.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit
import OSLog

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        do {
            window.rootViewController = try ResumeViewControllerAssembly().create()
        } catch {
            let logger = Logger()
            logger.error("Не удалось создать ResumeViewController:: \(error.localizedDescription)")
        }

        self.window = window
        return true
    }
}
