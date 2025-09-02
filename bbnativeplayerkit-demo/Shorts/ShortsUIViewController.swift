//
//  ShortsUIViewController.swift
//  bbnativeplayerkit-demo
//
//  Created by Olaf Timme on 10/06/2024.
//

import Foundation
import UIKit
import BBNativePlayerKit

class ShortsUIViewController: UIViewController, PlayerConfigurable {

    internal var bbShortsView: BBNativeShortsView? = nil
    var jsonUrl: String = "https://demo.bbvms.com/sh/43.json"
    var playerOptions: [String: Any] = ["skipShortsAdOnSwipe": true]
    
    var defaultJsonUrl: String {
        return "https://demo.bbvms.com/sh/43.json"
    }
    
    var defaultPlayerOptions: [String: Any] {
        return ["skipShortsAdOnSwipe": true]
    }
    
    var alertTitle: String {
        return "Enter Shorts demo configuration"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bbShortsView = BBNativeShorts.createShortsView(uiViewController: self, frame: view.frame, jsonUrl: jsonUrl, options: playerOptions)
        view.addSubview(bbShortsView!)
        bbShortsView?.translatesAutoresizingMaskIntoConstraints = false
        bbShortsView?.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        bbShortsView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0 ).isActive = true
        bbShortsView?.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        // Check if displayFormat is "list" for different sizing
        if let displayFormat = playerOptions["displayFormat"] as? String, displayFormat == "list" {
            // For list format: 16:9 aspect ratio
            bbShortsView?.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 9.0/16.0).isActive = true
        } else {
            // Default: full height
            bbShortsView?.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bbShortsView?.destroy()
        super.viewWillDisappear(animated)
    }
}
