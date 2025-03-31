//  BlueBillywigNativeiOSDemo
//
//  Created by Olaf Timme on 09/02/2021.
//

import Foundation
import UIKit
import BBNativePlayerKit

class OutStreamUIViewController: UIViewController {

    internal var jsonUrl:String = "https://demo.bbvms.com/a/native_sdk_outstream.json"
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textView: UITextView = {
       let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = NSTextAlignment.left
        textView.textColor = UIColor.blue
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = """
Below a player is added that will play when it comes into view and pauses when it goes out of view. This is done using the in- and outview settings of the playout in the Blue Billywig OVP.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam ut venenatis tellus in metus vulputate. Bibendum est ultricies integer quis auctor elit sed vulputate mi. Eros in cursus turpis massa tincidunt dui ut. Velit laoreet id donec ultrices tincidunt arcu non sodales neque. Adipiscing bibendum est ultricies integer quis.

Sit amet cursus sit amet. Malesuada proin libero nunc consequat interdum varius sit amet mattis. Sem integer vitae justo eget. Sed risus ultricies tristique nulla aliquet enim tortor at. Adipiscing enim eu turpis egestas.

Felis bibendum ut tristique et egestas. Bibendum neque egestas congue quisque egestas. Augue lacus viverra vitae congue eu consequat. Vel orci porta non pulvinar neque laoreet suspendisse interdum consectetur. Facilisis leo vel fringilla est. Nisl purus in mollis nunc sed id semper risus. Vel fringilla est ullamcorper eget nulla. Odio morbi quis commodo odio aenean sed adipiscing diam. Sagittis id consectetur purus ut.

Vestibulum lorem sed risus ultricies tristique. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Feugiat in fermentum posuere urna nec. A diam maecenas sed enim ut. Cursus mattis molestie a iaculis at erat pellentesque adipiscing. Sit amet consectetur adipiscing elit pellentesque habitant. Nisl nunc mi ipsum faucibus vitae aliquet nec.
Felis bibendum ut tristique et egestas. Bibendum neque egestas congue quisque egestas. Augue lacus viverra vitae congue eu consequat. Vel orci porta non pulvinar neque laoreet suspendisse interdum consectetur. Facilisis leo vel fringilla est. Nisl purus in mollis nunc sed id semper risus. Vel fringilla est ullamcorper eget nulla. Odio morbi quis commodo odio aenean sed adipiscing diam. Sagittis id consectetur purus ut.

Vestibulum lorem sed risus ultricies tristique. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Feugiat in fermentum posuere urna nec. A diam maecenas sed enim ut. Cursus mattis molestie a iaculis at erat pellentesque adipiscing. Sit amet consectetur adipiscing elit pellentesque habitant. Nisl nunc mi ipsum faucibus vitae aliquet nec.
"""
        return textView
    }()
    
    let textView2: UITextView = {
       let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = NSTextAlignment.left
        textView.textColor = UIColor.blue
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = """


Vestibulum lorem sed risus ultricies tristique. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Feugiat in fermentum posuere urna nec. A diam maecenas sed enim ut. Cursus mattis molestie a iaculis at erat pellentesque adipiscing. Sit amet consectetur adipiscing elit pellentesque habitant. Nisl nunc mi ipsum faucibus vitae aliquet nec.
Felis bibendum ut tristique et egestas. Bibendum neque egestas congue quisque egestas. Augue lacus viverra vitae congue eu consequat. Vel orci porta non pulvinar neque laoreet suspendisse interdum consectetur. Facilisis leo vel fringilla est. Nisl purus in mollis nunc sed id semper risus. Vel fringilla est ullamcorper eget nulla. Odio morbi quis commodo odio aenean sed adipiscing diam. Sagittis id consectetur purus ut.

Vestibulum lorem sed risus ultricies tristique. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Feugiat in fermentum posuere urna nec. A diam maecenas sed enim ut. Cursus mattis molestie a iaculis at erat pellentesque adipiscing. Sit amet consectetur adipiscing elit pellentesque habitant. Nisl nunc mi ipsum faucibus vitae aliquet nec.
"""
        return textView
    }()

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        v.backgroundColor = .white
        return v
    }()

    private var bbPlayerView: BBNativePlayerView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)

        // setup scrollable content
        scrollView.frame = view.frame
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 2800)
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

        scrollView.addSubview(containerView)
        containerView.backgroundColor = .systemYellow
        containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0).isActive = true
                
        containerView.addSubview(textView)
        textView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        textView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        textView.backgroundColor = .blue
        containerView.layoutIfNeeded()

        // Create player using playout with inview play and outview pause action
        bbPlayerView = BBNativePlayer.createPlayerView(uiViewController: self, frame: view.frame, jsonUrl: jsonUrl)

        // Add player to scrollView
        scrollView.addSubview(bbPlayerView!)
        
        // Set player constraints
        bbPlayerView?.translatesAutoresizingMaskIntoConstraints = false
        bbPlayerView?.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 0 ).isActive = true
        bbPlayerView?.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0 ).isActive = true
        bbPlayerView?.widthAnchor.constraint(equalTo: containerView.widthAnchor) .isActive = true
        // Don't use a height constraint to let the player remain responsive to the ad height
        
        containerView.addSubview(textView2)
        textView2.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        textView2.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        textView2.topAnchor.constraint(equalTo: bbPlayerView!.bottomAnchor).isActive = true
        textView2.heightAnchor.constraint(equalToConstant: 1000).isActive = true
    }
}
