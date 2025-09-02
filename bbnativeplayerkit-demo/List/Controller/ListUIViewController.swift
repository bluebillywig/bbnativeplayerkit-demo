

import Foundation
import UIKit

class ListUIViewController: UIViewController, PlayerConfigurable {

    var jsonUrl: String = "https://demo.bbvms.com/json/search?cliplistid=1623750782772352&allowCache=true"
    var playerOptions: [String: Any] = ["showChromeCastMiniControlsInPlayer": true]
    
    var defaultJsonUrl: String {
        return "https://demo.bbvms.com/json/search?cliplistid=1623750782772352&allowCache=true"
    }
    
    var defaultPlayerOptions: [String: Any] {
        return ["showChromeCastMiniControlsInPlayer": true]
    }
    
    var alertTitle: String {
        return "Enter Video List demo configuration"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let layout = UICollectionViewFlowLayout()
        let listViewController = ListViewController(collectionViewLayout: layout)
        
        // Pass configuration to the list controller
        listViewController.dataSourceUrl = jsonUrl
        listViewController.defaultPlayerOptions = playerOptions
        
        addChild(listViewController)
        view.addSubview(listViewController.view)
        listViewController.didMove(toParent: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}


