//
//  Tab1ViewController.swift
//  BlueBillywigNativeiOSDemo
//
//  Created by Olaf Timme on 09/02/2021.
//

import Foundation
import UIKit
import BBNativePlayerKit

class PrePostrollUIViewController: UIViewController, PlayerConfigurable {
    
    var jsonUrl: String = "https://demo.bbvms.com/p/native_sdk_preroll/c/4256600.json"
    var playerOptions: [String: Any] = [:]
    
    var defaultJsonUrl: String {
        return "https://demo.bbvms.com/p/native_sdk_preroll/c/4256600.json"
    }
    
    var defaultPlayerOptions: [String: Any] {
        return playerOptions
    }
    
    var alertTitle: String {
        return "Enter Pre-Post-Roll demo configuration"
    }
    
    lazy var playerTopConstraint = bbPlayerView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 300 )
    lazy var playerWidthConstraint = bbPlayerView?.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10)
    lazy var playerHeightConstraint = bbPlayerView?.heightAnchor.constraint(equalToConstant: (view.frame.size.width - 10) * 9/16)
    
    let textView: UITextView = {
       let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = NSTextAlignment.left
        textView.textColor = UIColor.blue
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam ut venenatis tellus in metus vulputate. Bibendum est ultricies integer quis auctor elit sed vulputate mi. Eros in cursus turpis massa tincidunt dui ut. Velit laoreet id donec ultrices tincidunt arcu non sodales neque. Adipiscing bibendum est ultricies integer quis.
Sit amet cursus sit amet. Malesuada proin libero nunc consequat interdum varius sit amet mattis. Sem integer vitae justo eget. Sed risus ultricies tristique nulla aliquet enim tortor at. Adipiscing enim eu turpis egestas.
Felis bibendum ut tristique et egestas. Bibendum neque egestas congue quisque egestas. Augue lacus viverra vitae congue eu consequat. Vel orci porta non pulvinar neque laoreet suspendisse interdum consectetur. Facilisis leo vel fringilla est. Nisl purus in mollis nunc sed id semper risus. Vel fringilla est ullamcorper eget nulla. Odio morbi quis commodo odio aenean sed adipiscing diam. Sagittis id consectetur purus ut.
"""
        return textView
    }()
   
   
    private var bbPlayerView: BBNativePlayerView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        textView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        textView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        view.layoutIfNeeded()
        
        
        // Create player with content playing pre- and postroll advertisements
        bbPlayerView = BBNativePlayer.createPlayerView(uiViewController: self, frame: view.frame, jsonUrl: jsonUrl, options: playerOptions)
        bbPlayerView?.delegate = self
        // Add player to View
        view.addSubview(bbPlayerView!)
        
        // Set player constraints
        bbPlayerView?.translatesAutoresizingMaskIntoConstraints = false
        bbPlayerView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if ( view.safeAreaLayoutGuide.layoutFrame.width > view.safeAreaLayoutGuide.layoutFrame.height ) {
            self.playerTopConstraint?.constant = 0
            self.playerWidthConstraint?.constant = view.frame.size.width
            self.playerHeightConstraint?.constant = view.frame.size.height
        } else {
            self.playerTopConstraint?.constant = 300
            self.playerWidthConstraint?.constant = -10
            self.playerHeightConstraint?.constant = (view.frame.size.width - 10) * 9/16
        }
        
        playerTopConstraint?.isActive = true
        playerWidthConstraint?.isActive = true
        playerHeightConstraint?.isActive = true
     
        
        // create rect for player to exclude text to render there
        let rect = CGRect(x: 0, y: 200, width: view.bounds.size.width, height: view.bounds.size.width * 9/16)
        textView.textContainer.exclusionPaths = [UIBezierPath(rect: rect)]
        
        // place the cast button in the navigation bar
        if let castButton = bbPlayerView?.player.createChromeCastButton {
            castButton.tintColor = UIColor.black
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: castButton)
        }
    }
    
    //MARK: - Handle rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            DispatchQueue.main.async {
                self.playerTopConstraint?.constant = 0
                self.playerWidthConstraint?.constant = self.view.frame.size.width
                self.playerHeightConstraint?.constant = self.view.frame.size.height
            }
        } else {
            DispatchQueue.main.async {
                self.playerTopConstraint?.constant = 300
                self.playerWidthConstraint?.constant = -10
                self.playerHeightConstraint?.constant = (self.view.frame.size.width - 10) * 9/16
            }
        }
    }
}
//Implements BBNativePlayerViewDelegate to receive all API events and logs them in the DebugUITextView
extension PrePostrollUIViewController: BBNativePlayerViewDelegate {
   
    
    func bbNativePlayerView(didTriggerUIPanGesture playerView: BBNativePlayerView, translation: CGPoint) {
        print("***** didTriggerUIPangesture: translation = \(translation)")
    }
}
