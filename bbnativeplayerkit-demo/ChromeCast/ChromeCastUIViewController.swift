//
//  ChromeCastUIViewController.swift
//  bbnativeplayerkit-demo
//
//  Created by Olaf Timme on 16/02/2022.
//

import UIKit
import BBNativePlayerKit
import bbnativeshared

class ChromeCastUIViewController: UIViewController, PlayerConfigurable {

    var jsonUrl: String = "https://demo.bbvms.com/p/default/c/4146866.json"
    var playerOptions: [String: Any] = ["showChromeCastMiniControlsInPlayer": true]
    
    var defaultJsonUrl: String {
        return "https://demo.bbvms.com/p/default/c/4146866.json"
    }
    
    var defaultPlayerOptions: [String: Any] {
        return ["showChromeCastMiniControlsInPlayer": true]
    }
    
    var alertTitle: String {
        return "Enter ChromeCast demo configuration"
    }

    private var bbPlayerView: BBNativePlayerView? = nil
    lazy var playerHeightConstraint = bbPlayerView?.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width * 9/16)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // create player view using the embed url
        bbPlayerView = BBNativePlayer.createPlayerView(uiViewController: self, frame: view.frame, jsonUrl: jsonUrl, options: playerOptions)
        
        // use constraints to place and size the player view
        view.addSubview(bbPlayerView!)
        bbPlayerView?.translatesAutoresizingMaskIntoConstraints = false
        bbPlayerView?.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        bbPlayerView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0 ).isActive = true
        bbPlayerView?.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        if ( view.safeAreaLayoutGuide.layoutFrame.width > view.safeAreaLayoutGuide.layoutFrame.height ) {
            self.playerHeightConstraint?.constant = self.view.safeAreaLayoutGuide.layoutFrame.height
        } else {
            self.playerHeightConstraint?.constant = self.view.safeAreaLayoutGuide.layoutFrame.width * 9/16
        }
        playerHeightConstraint?.isActive = true
        
        // place the cast button in the navigation bar
        if let castButton = bbPlayerView?.player.createChromeCastButton {
            castButton.tintColor = UIColor.black
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: castButton)
        }
    }
}
