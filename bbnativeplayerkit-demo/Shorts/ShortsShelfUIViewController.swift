//
//  ShortsShelfUIViewController.swift
//  bbnativeplayerkit-demo
//
//  Created by Olaf Timme on 25/02/2025.
//

import Foundation
import UIKit
import BBNativePlayerKit

class ShortsShelfUIViewController: UIViewController, PlayerConfigurable {

    internal var bbShortsViewShelf: BBNativeShortsView? = nil
    var jsonUrl: String = "https://testsuite.acc.bbvms.com/sh/51.json"
    var playerOptions: [String: Any] = ["displayFormat": "list"]
    
    var defaultJsonUrl: String {
        return "https://testsuite.acc.bbvms.com/sh/51.json"
    }
    
    var defaultPlayerOptions: [String: Any] {
        return playerOptions
    }
    
    var alertTitle: String {
        return "Enter Shorts Shelf demo configuration"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bbShortsViewShelf = BBNativeShorts.createShortsView(uiViewController: self, frame: view.frame, jsonUrl: jsonUrl, options: playerOptions)
        view.addSubview(bbShortsViewShelf!)
        bbShortsViewShelf?.translatesAutoresizingMaskIntoConstraints = false
        bbShortsViewShelf?.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        bbShortsViewShelf?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0 ).isActive = true
        bbShortsViewShelf?.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        bbShortsViewShelf?.heightAnchor.constraint(equalToConstant: self.view.safeAreaLayoutGuide.layoutFrame.width * 9/16).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bbShortsViewShelf?.destroy()
        super.viewWillDisappear(animated)
    }
}
