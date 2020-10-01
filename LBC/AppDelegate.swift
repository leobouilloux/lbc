//
//  AppDelegate.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var applicationCoordinator: ApplicationCoordinator?

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            return true
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let provider = NetworkProvider()

            applicationCoordinator = ApplicationCoordinator(window: window,
                                                            coordinatorFactory: CoordinatorFactory(),
                                                            provider: provider)
            window.makeKeyAndVisible()
            applicationCoordinator?.start()
            self.window = window
            return true
        }
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}
