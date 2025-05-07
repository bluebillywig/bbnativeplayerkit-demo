//
//  BBRendererViewController.swift
//  bbnativeplayerkit-demo
//
//  Created by Olaf Timme on 05/05/2025.
//
import Foundation
import UIKit
import BBNativePlayerKit

class BBRendererUIViewController: UIViewController {

    internal var bbRendererView: BBNativeRendererView? = nil
    internal var jsonUrl:String = "https://bb.dev.bbvms.com/r/puc_inarticle.json"
    internal var vastXml = ""
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
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

Vestibulum lorem sed risus ultricies tristique. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Feugiat in fermentum posuere urna nec. A diam maecenas sed enim ut. Cursus mattis molestie a iaculis at erat pellentesque adipiscing. Sit amet consectetur adipiscing elit pellentesque habitant. Nisl nunc mi ipsum faucibus vitae aliquet nec. Ullamcorper eget nulla facilisi etiam dignissim. Vitae semper quis lectus nulla at volutpat. Fames ac turpis egestas sed tempus urna et pharetra. Lectus quam id leo in. Faucibus a pellentesque sit amet. Id interdum velit laoreet id donec. Massa sed elementum tempus egestas.

In arcu cursus euismod quis viverra nibh cras pulvinar mattis. Et odio pellentesque diam volutpat commodo sed egestas egestas fringilla. Odio morbi quis commodo odio aenean sed adipiscing diam. Amet mauris commodo quis imperdiet massa tincidunt nunc. Lectus sit amet est placerat in egestas erat imperdiet.

Aliquam faucibus purus in massa tempor nec feugiat nisl. Nisl vel pretium lectus quam id leo in. Urna porttitor rhoncus dolor purus. Ac ut consequat semper viverra nam libero justo. Eu turpis egestas pretium aenean pharetra magna ac placerat. Volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend. Nam libero justo laoreet sit amet. In mollis nunc sed id semper risus. Pretium nibh ipsum consequat nisl vel pretium lectus quam. Nullam eget felis eget nunc lobortis mattis. Phasellus egestas tellus rutrum tellus pellentesque eu. Vulputate enim nulla aliquet porttitor lacus luctus.
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
Est sit amet facilisis magna etiam tempor orci eu lobortis. Arcu cursus vitae congue mauris rhoncus aenean. Non nisi est sit amet facilisis magna etiam tempor orci. Dictum at tempor commodo ullamcorper a lacus vestibulum. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Consectetur libero id faucibus nisl tincidunt eget.

Sodales ut eu sem integer vitae justo eget magna. Pretium quam vulputate dignissim suspendisse in est ante in. In nisl nisi scelerisque eu. Turpis egestas pretium aenean pharetra magna ac placerat vestibulum. Faucibus interdum posuere lorem ipsum dolor. Vehicula ipsum a arcu cursus vitae congue mauris rhoncus aenean. Dui sapien eget mi proin. In cursus turpis massa tincidunt.

Aliquet porttitor lacus luctus accumsan. Nulla at volutpat diam ut venenatis tellus in metus. Sed elementum tempus egestas sed. At erat pellentesque adipiscing commodo elit at imperdiet dui. Ac turpis egestas maecenas pharetra convallis posuere morbi leo. Aliquam sem fringilla ut morbi tincidunt augue. Cras fermentum odio eu feugiat.

At volutpat diam ut venenatis tellus in metus vulputate. Est sit amet facilisis magna etiam. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet enim. Netus et malesuada fames ac. Ipsum dolor sit amet consectetur adipiscing. Nulla facilisi etiam dignissim diam quis enim lobortis scelerisque. Urna duis convallis convallis tellus id interdum velit laoreet. Aenean sed adipiscing diam donec. Amet mattis vulputate enim nulla aliquet porttitor lacus. Habitant morbi tristique senectus et netus et malesuada fames ac. At elementum eu facilisis sed odio morbi. Malesuada bibendum arcu vitae elementum.

Turpis in eu mi bibendum neque egestas. Vulputate mi sit amet mauris commodo quis. Enim blandit volutpat maecenas volutpat blandit aliquam. At elementum eu facilisis sed odio morbi quis commodo odio. Magnis dis parturient montes nascetur ridiculus mus mauris vitae ultricies. Aliquet sagittis id consectetur purus. Nunc aliquet bibendum enim facilisis gravida neque convallis a. Id eu nisl nunc mi ipsum faucibus.

Nulla porttitor massa id neque aliquam vestibulum morbi. Id leo in vitae turpis massa. Morbi tristique senectus et netus et malesuada fames ac turpis. Porttitor eget dolor morbi non arcu risus. Ac ut consequat semper viverra nam libero justo laoreet. Tempor id eu nisl nunc mi ipsum faucibus vitae aliquet. Et netus et malesuada fames ac turpis. Lectus quam id leo in. Tempus quam pellentesque nec nam. Massa ultricies mi quis hendrerit dolor. Amet consectetur adipiscing elit ut aliquam purus sit. Odio ut enim blandit volutpat maecenas volutpat blandit aliquam etiam. Mauris sit amet massa vitae tortor condimentum lacinia quis.

Tortor pretium viverra suspendisse potenti nullam ac. Quam viverra orci sagittis eu volutpat odio. Tortor dignissim convallis aenean et tortor at risus. Tortor consequat id porta nibh venenatis cras. Vulputate ut pharetra sit amet aliquam id. Id neque aliquam vestibulum morbi blandit cursus risus at ultrices.

Non pulvinar neque laoreet suspendisse interdum consectetur libero. Volutpat odio facilisis mauris sit. Eu mi bibendum neque egestas congue quisque egestas diam. Turpis nunc eget lorem dolor sed viverra ipsum nunc aliquet. Risus quis varius quam quisque id diam vel quam elementum. Faucibus pulvinar elementum integer enim. Elementum nisi quis eleifend quam. Gravida in fermentum et sollicitudin ac orci. Elementum sagittis vitae et leo duis ut. Lectus sit amet est placerat in egestas. Lacus luctus accumsan tortor posuere. Sem nulla pharetra diam sit amet nisl. At tempor commodo ullamcorper a lacus vestibulum sed arcu. A scelerisque purus semper eget. Tortor aliquam nulla facilisi cras fermentum. Mauris rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar. Sapien eget mi proin sed libero enim. Duis tristique sollicitudin nibh sit amet commodo. Habitant morbi tristique senectus et netus et. Blandit libero volutpat sed cras ornare arcu dui vivamus arcu.
"""
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        //containerView.heightAnchor.constraint(equalToConstant: 2500).isActive = true
        
        
        containerView.addSubview(textView)
        textView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        textView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 752).isActive = true
      
        let adContainer = UIView(frame: .zero)
        adContainer.backgroundColor = .white
        adContainer.layer.cornerRadius = 10
        adContainer.layer.borderWidth = 1
        adContainer.layer.masksToBounds = true
        adContainer.layer.borderColor = UIColor.black.cgColor
        
        containerView.addSubview(adContainer)
        adContainer.translatesAutoresizingMaskIntoConstraints = false
        adContainer.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10 ).isActive = true
        adContainer.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        adContainer.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -20).isActive = true
        adContainer.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        // BB-NATIVE-RENDERER
        bbRendererView = BBNativeRenderer.createRendererView(uiViewController: self, frame: view.frame, jsonUrl: "https://bb.dev.bbvms.com/r/puc_inarticle.json")
        
        adContainer.addSubview(bbRendererView!)
        bbRendererView?.translatesAutoresizingMaskIntoConstraints = false
        bbRendererView?.topAnchor.constraint(equalTo: adContainer.topAnchor, constant: 0 ).isActive = true
        bbRendererView?.leftAnchor.constraint(equalTo: adContainer.leftAnchor, constant: 0).isActive = true
        bbRendererView?.widthAnchor.constraint(equalToConstant: 120).isActive = true
        bbRendererView?.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        bbRendererView?.playerViewDelegate = self // NOTE: this is the Player delegate, not the Renderer delegate
        
        let adTextView = UITextView()
        adTextView.contentInsetAdjustmentBehavior = .automatic
        adTextView.textAlignment = NSTextAlignment.left
        adTextView.textColor = UIColor.blue
        adTextView.backgroundColor = UIColor.clear
        adTextView.textColor = UIColor.black
        adTextView.font = UIFont.systemFont(ofSize: 23)
        adTextView.translatesAutoresizingMaskIntoConstraints = false
        adTextView.text = "An awsome message"
        adTextView.textContainer.maximumNumberOfLines
        
        adContainer.addSubview(adTextView)
        adTextView.translatesAutoresizingMaskIntoConstraints = false
        adTextView.centerYAnchor.constraint(equalTo: adContainer.centerYAnchor, constant: 0 ).isActive = true
        adTextView.leftAnchor.constraint(equalTo: bbRendererView!.rightAnchor, constant: 10).isActive = true
        adTextView.widthAnchor.constraint(equalTo: adContainer.widthAnchor, constant: -120).isActive = true
        adTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerView.addSubview(textView2)
        textView2.topAnchor.constraint(equalTo: bbRendererView!.bottomAnchor, constant: 0).isActive = true
        textView2.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        textView2.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        textView2.heightAnchor.constraint(equalToConstant: 750).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bbRendererView?.destroy()
        super.viewWillDisappear(animated)
    }
}

extension BBRendererUIViewController: BBNativePlayerViewDelegate {
    func bbNativePlayerView(didTriggerApiReady playerView: BBNativePlayerView) {
        print("***** VIEWCONTROLLER TOP didTriggerApiReady")
        self.vastXml = self.vastXml.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let playoutOverrides: [String: String] = [:]
        print("***** vastXML = \(self.vastXml)")
        bbRendererView?.bootstrap(config: ["code": "1234abcd", "vastXml": vastXml], element: nil, playoutOverrides: playoutOverrides)
    }
}
