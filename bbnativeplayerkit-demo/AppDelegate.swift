//
//  AppDelegate.swift
//  BlueBillywigNativeiOSDemo
//
//  Created by Olaf Timme on 08/02/2021.
//

import UIKit
import BBNativePlayerKit
import bbnativeshared
import AVKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var bbPlayerView: BBNativePlayerView? = nil
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let rootViewController = application.windows.first?.rootViewController {
            bbPlayerView = BBNativePlayer.createPlayerView(uiViewController: rootViewController, frame: rootViewController.view.frame, jsonUrl: "", options: ["showChromeCastMiniControlsInPlayer": true])
            rootViewController.view.addSubview(bbPlayerView!)
            // place the cast button in the navigation bar
            if let castButton = bbPlayerView?.player.createChromeCastButton {
                castButton.tintColor = UIColor.black
                if let navigationController = application.windows[0].rootViewController as? UINavigationController {
                    navigationController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: castButton)
                }
            }
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        guard let rvc = window?.rootViewController else {
            return .portrait
        }
        if let vc = getCurrentViewController(rvc) {
            if vc is AVPlayerViewController {
                return .allButUpsideDown
            }
        }
        return .portrait
    }

    func getCurrentViewController(_ vc: UIViewController) -> UIViewController? {
        if let pvc = vc.presentedViewController {
            return getCurrentViewController(pvc)
        } else if let svc = vc as? UISplitViewController, svc.viewControllers.count > 0 {
            return getCurrentViewController(svc.viewControllers.last!)
        } else if let nc = vc as? UINavigationController, nc.viewControllers.count > 0 {
            return getCurrentViewController(nc.topViewController!)
        } else if let tbc = vc as? UITabBarController {
            if let svc = tbc.selectedViewController {
                return getCurrentViewController(svc)
            }
        }
        return vc
    }


}

