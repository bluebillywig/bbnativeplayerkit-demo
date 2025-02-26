//
//  ShortsShelfUIViewController.swift
//  bbnativeplayerkit-demo
//
//  Created by Olaf Timme on 25/02/2025.
//

import Foundation
import UIKit
import BBNativePlayerKit

class ShortsShelfUIViewController: UIViewController {

    internal var bbShortsViewShelf: BBNativeShortsView? = nil
    internal var jsonUrl:String = "https://testsuite.acc.bbvms.com/sh/17.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bbShortsViewShelf = BBNativeShorts.createShortsView(uiViewController: self, frame: view.frame, jsonUrl: jsonUrl, options: ["displayFormat": "list"])
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
