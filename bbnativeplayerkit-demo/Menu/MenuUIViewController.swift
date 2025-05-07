//
//  Tab1ViewController.swift
//  BlueBillywigNativeiOSDemo
//
//  Created by Olaf Timme on 09/02/2021.
//

import Foundation
import UIKit
import BBNativePlayerKit

class MenuUIViewController: UIViewController, MenuCollectionViewControllerDelegate {
    
    private var vastXML: String = ""
    
    private let backGroundImage:UIImageView = {
        let imageView:UIImageView = UIImageView()
        imageView.image = UIImage(named: "wp3692445-ios-12-wallpapers")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bluebillywig logo WIT")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backGroundImage)
        backGroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        backGroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backGroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backGroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        
        
        
        let menuCollectionViewController = MenuCollectionViewController()
        menuCollectionViewController.delegate = self
        menuCollectionViewController.view.frame = view.frame
        addChild(menuCollectionViewController)
        let menuCollectionView = menuCollectionViewController.view
        
        let numberOfButtonRows:CGFloat = 4
        
        view.addSubview(menuCollectionView!)
        menuCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        menuCollectionView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuCollectionView?.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        menuCollectionView?.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 0).isActive = true
        menuCollectionView?.heightAnchor.constraint(equalToConstant: (180 * numberOfButtonRows)).isActive = true
        
        menuCollectionViewController.didMove(toParent: self)
        
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: menuCollectionView!.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        view.layoutIfNeeded()
    }
    
    func didSelectMenuItem(menuItem: MenuItem) {
        if ( menuItem.name != "" ) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: menuItem.name) {
                vc.title = menuItem.title
                
                if ( menuItem.name == "Outstream" ) {
                    let alertController = UIAlertController(title: "Enter your outstream json url", message: nil, preferredStyle: .alert)
                    
                    alertController.addTextField { textField in
                        textField.text = "https://demo.bbvms.com/a/native_sdk_outstream.json"
                    }
                    
                    let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
                        if let text = alertController.textFields?.first?.text {
                            if let osvc: OutStreamUIViewController = vc as? OutStreamUIViewController {
                                osvc.jsonUrl = text
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                    
                    alertController.addAction(submitAction)
                    present(alertController, animated: true, completion: nil)
                } else if (menuItem.name == "shorts"){
                    let alertController = UIAlertController(title: "Enter your shorts json url", message: nil, preferredStyle: .alert)
                    
                    alertController.addTextField { textField in
                        textField.text = "https://demo.bbvms.com/sh/43.json"
                    }
                    
                    let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
                        if let text = alertController.textFields?.first?.text {
                            if let svc: ShortsUIViewController = vc as? ShortsUIViewController {
                                svc.jsonUrl = text
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                    
                    alertController.addAction(submitAction)
                    present(alertController, animated: true, completion: nil)
                } else if (menuItem.name == "shorts_shelf"){
                    let alertController = UIAlertController(title: "Enter your shorts json url", message: nil, preferredStyle: .alert)
                    
                    alertController.addTextField { textField in
                        textField.text = "https://testsuite.acc.bbvms.com/sh/51.json"
                    }
                    
                    let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
                        if let text = alertController.textFields?.first?.text {
                            if let svc: ShortsShelfUIViewController = vc as? ShortsShelfUIViewController {
                                svc.jsonUrl = text
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                    
                    alertController.addAction(submitAction)
                    present(alertController, animated: true, completion: nil)
                } else if (menuItem.name == "BBRenderer") {
                    print("***** BBRENDERER")
                    let alertController = UIAlertController(title: "Enter your BBRenderer json url", message: nil, preferredStyle: .alert)
                    
                    self.setVastXML()
                    
                    alertController.addTextField { textField in
                        textField.text = "https://bb.dev.bbvms.com/r/puc_inarticle.json"
                    }
                    alertController.addTextField { textField in
                        textField.text = self.vastXML
                    }
                    
                    let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
                        print("***** Submitted")
                        if let jsonString = alertController.textFields?.first?.text {
                            if let vastString = alertController.textFields?[1].text {
                                if let bvc: BBRendererUIViewController = vc as? BBRendererUIViewController {
                                    bvc.jsonUrl = jsonString
                                    bvc.vastXml = vastString
                                    self.navigationController?.pushViewController(bvc, animated: true)
                                }
                            }
                        }
                    }
                    
                    alertController.addAction(submitAction)
                    present(alertController, animated: true, completion: nil)
                } else {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}



struct MenuItem {
    var name: String
    var title: String
    var color1: UIColor
    var color2: UIColor
}


protocol MenuCollectionViewControllerDelegate {
    func didSelectMenuItem( menuItem: MenuItem )
}

class MenuCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public var delegate: MenuCollectionViewControllerDelegate?
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        view.backgroundColor = .clear
        
        var menuItem = MenuItem(name: "api",
                                title: "API",
                                color1: UIColor.init(hex: "#E6787BFF") ?? UIColor.systemGray,
                                color2: UIColor.init(hex: "#DA4749FF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        menuItem = MenuItem(name: "list",
                            title: "Video List",
                            color1: UIColor.init(hex: "#E7AA5AFF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#DC8237FF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        menuItem = MenuItem(name: "In-Out-View",
                            title: "In-Out-View",
                            color1: UIColor.init(hex: "#793BEBFF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#4823E2FF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        menuItem = MenuItem(name: "Outstream",
                            title: "Outstream",
                            color1: UIColor.init(hex: "#78D0F2FF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#47BAECFF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        menuItem = MenuItem(name: "Pre-Post-Roll",
                            title: "Pre-Post-Roll",
                            color1: UIColor.init(hex: "#9FE499FF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#71D767FF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        menuItem = MenuItem(name: "WebView",
                            title: "WebView",
                            color1: UIColor.init(hex: "#DE433CFF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#CE2824FF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        menuItem = MenuItem(name: "Chromecast",
                            title: "ChromeCast",
                            color1: UIColor.init(hex: "#793BEBFF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#47BAECFF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        menuItem = MenuItem(name: "ChromeCast_Controls",
                            title: "ChromeCast 2",
                            color1: UIColor.init(hex: "#793BEBFF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#47BAECFF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        //        menuItem = MenuItem(name: "Load_json_url",
        //                            title: "Load JSON",
        //                            color1: UIColor.init(hex: "#793BEBFF") ?? UIColor.systemGray,
        //                            color2: UIColor.init(hex: "#47BAECFF") ?? UIColor.systemGray)
        //        menuItem = MenuItem(name: "chapters",
        //                                title: "Chapters",
        //                                color1: UIColor.init(hex: "#E6787BFF") ?? UIColor.systemGray,
        //                                color2: UIColor.init(hex: "#DA4749FF") ?? UIColor.systemGray)
        //        menuItems.append(menuItem)
        //        menuItem = MenuItem(name: "highlights",
        //                                title: "Highlights",
        //                                color1: UIColor.init(hex: "#DE433CFF") ?? UIColor.systemGray,
        //                                color2: UIColor.init(hex: "#CE2824FF") ?? UIColor.systemGray)
        //        menuItems.append(menuItem)
        menuItem = MenuItem(name: "shorts",
                            title: "Shorts",
                            color1: UIColor.init(hex: "#E7AA5AFF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#DC8237FF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        
        menuItem = MenuItem(name: "shorts_shelf",
                            title: "Shorts Shelf",
                            color1: UIColor.init(hex: "#E7AA5AFF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#DC8237FF") ?? UIColor.systemGray)
        menuItem = MenuItem(name: "BBRenderer",
                            title: "BBRenderer",
                            color1: UIColor.init(hex: "#793BEBFF") ?? UIColor.systemGray,
                            color2: UIColor.init(hex: "#4823E2FF") ?? UIColor.systemGray)
        menuItems.append(menuItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        cell.setup(with: menuItems[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didSelectMenuItem(menuItem: menuItems[indexPath.row])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    deinit {
    }
}




class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    let button:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system) as UIButton
        button.backgroundColor = UIColor.systemTeal
        button.setTitle("", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.white, for:UIControl.State.normal)
        button.sizeToFit()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let button1 = CreateButton( title: "API", color1: UIColor.init(hex: "#E7AA5AFF")!, color2: UIColor.init(hex: "#DC8237FF")!)
        button1.addTarget(self, action: #selector(openMenuItem), for: .touchUpInside)
        addSubview(button1)
        button1.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        button1.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with menuItem: MenuItem) {
        button.setTitle(menuItem.title, for: UIControl.State.normal)
        button.isEnabled = false
        button.applyGradient(colours: [menuItem.color1, menuItem.color2])
        button.layer.cornerRadius = 20
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        button.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
    }
    
    
    deinit {
    }
    
    @objc func openMenuItem(gesture: UITapGestureRecognizer) {
        
    }
    
    
    private func CreateButton( title: String, color1: UIColor, color2: UIColor)-> UIButton {
        
        return button
    }
}

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
        gradient.colors = colours.map { $0.cgColor }
        
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.cornerRadius = 20
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension MenuUIViewController {
    func setVastXML() {
        vastXML = """
         <?xml version="1.0" encoding="UTF-8"?>
 <VAST xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="vast.xsd" version="3.0">
  <Ad id="5925573263">
   <InLine>
    <AdSystem>GDFP</AdSystem>
    <AdTitle>External - Single Inline Linear</AdTitle>
    <Description><![CDATA[External - Single Inline Linear ad]]></Description>
    <Error><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=videoplayfailed[ERRORCODE]]]></Error>
    <Impression><![CDATA[https://pagead2.googlesyndication.com/pcs/view?xai=AKAOjsuW29e1GlUDh8tv485bJvOjly3vXoSKTdLEltgoSw_ZJW9JHnJkJQ4cubwBuzwbkEec106nx-nTnrnBDLNRHPa9uughHPEhOdOb_KcJBOAZSVpwrrPmOlBSiWHuFMTfUHBdGsGV2Tzdg6JqO2Qw7lSwPPKn0ZRmngiLTWf3bKr356uZyjOsI_6oMsKWxXgcCZmZdV4fEJCcpPZLXvTtfQb2bPbvkfP5URTRdjf-lIAWB_GcCbDkt9kuIvt8czpBFvTMnVk1X5Lb-nHgSB9Wckn7n8ASmz-an4Jgt6_2uCp7o1DO1NKyW_wER4iAZN1HEO9u21DUUruTzErzHPeyTds-xLmusdLfUXLFz-ciHnAbyBk540OA5ys1PG41qDrbALsh88_wIu5V&sig=Cg0ArKJSzMDE5l9Q8hxlEAE&uach_m=%5BUACH%5D&adurl=]]></Impression>
    <Creatives>
     <Creative id="138381721867" AdID="H0Hrk8zCNZI" sequence="1">
      <CreativeExtensions><CreativeExtension type="UniversalAdId"><UniversalAdId idRegistry="googlevideo">H0Hrk8zCNZI</UniversalAdId></CreativeExtension></CreativeExtensions>
      <Linear>
       <Duration>00:00:10</Duration>
       <TrackingEvents>
        <Tracking event="start"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=part2viewed&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="firstQuartile"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=videoplaytime25&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="midpoint"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=videoplaytime50&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="thirdQuartile"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=videoplaytime75&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="complete"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=videoplaytime100&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="mute"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=admute&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="unmute"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=adunmute&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="rewind"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=adrewind&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="pause"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=adpause&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="resume"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=adresume&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="creativeView"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=vast_creativeview&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="fullscreen"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=adfullscreen&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="acceptInvitationLinear"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=acceptinvitation&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="closeLinear"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=adclose&ad_mt=%5BAD_MT%5D]]></Tracking>
        <Tracking event="exitFullscreen"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=vast_exit_fullscreen&ad_mt=%5BAD_MT%5D]]></Tracking>
       </TrackingEvents>
       <VideoClicks>
        <ClickThrough id="GDFP"><![CDATA[https://pagead2.googlesyndication.com/pcs/click?xai=AKAOjsvha2HR3hxN-YrsxYlG4zaecfu7GT_HHbWo8YZOMvhPDGo4cmim9rscV1xo-nloOHmJrUYuxYhThwDi0h38ySQX3ZSENVlGC4-GgmYGGKI41ZAzJLgAjg31igjU5fkqXKrlbpF4mGZg9cfAQgtc7lVdX2MADxGWXTKFHbCh4nmMv_B6pU4dhgxIhfy2UV6pnWbSXmBw9EIwAa0zJN3weQAejUHC-dyTzJmRoWDrZYN95diHZDUfiJ7EQMYiZD0EjJkmDGzs6I3eT9NtOdGzAGPyagqeCPrXcj0TkP6wIW83nx5V_tY9LMDQIpBKZFnb7C1d2dUp9BhoEto4X16YnOepHgIYjQoEeYokMMCgIYC_rzZ1zSA4A393QJA&sig=Cg0ArKJSzNHfkZBaDO8m&fbs_aeid=%5Bgw_fbsaeid%5D&adurl=https://googleads.github.io/googleads-ima-html5/vsi/]]></ClickThrough>
       </VideoClicks>
       <Icons>
        <Icon program="GoogleWhyThisAd" width="18" height="18" xPosition="right" yPosition="bottom">
         <StaticResource creativeType="image/png"><![CDATA[https://imasdk.googleapis.com/formats/wta/help_outline_white_24dp_with_3px_trbl_padding.png?wp=ca-pub-9939518381636264]]></StaticResource>
         <IconClicks>
          <IconClickThrough><![CDATA[https://adssettings.google.com/whythisad?source=display&reasons=AdhHJETQuA4w0sIB8KRw2QTdhIY8-R0F5iCDIZwM7twC0uKlPRVDQVQQAtr4kNCq8KoY9edHdCQHRqpNal4gUfEbZUjnvT0e_7GeggRBOF_zMuMx7bTyc-Mjc9sD4fYSvLCgy3bMbxWXIJD-IMaPI5TgwZVLI39L25lfhenZGOSfYyL5futJ3I4f5iiVON2XAeyIKpB249LBufGfoQaWJj1Xr6Cqj0ma47HbcHwbr1-bmX-WJ_k-ZV_WCBzZEJDxmp2HkduTGzqeWX1qy-Fo-RqZOlBc5dw0WSo2ZDf-gZhA043DaILv29yXtehHOhRUonLWQQkZSTSbHFtfBQ-EzpPvi0_1PyFlF2xFQxy56uodOkH2a-YPZPdClCk5DcHlDjVzJyh8pfUlwMpyOa3BM7UP47gmIng-gKXI-ExWPY8t-BfkM6KngfZ_Y9EE1NbrMPz_7azC9Pulz07SuFuPL4NCUwNo3Ek311wEMRm4nj1EJh1Y8JspNgxcHw0-xIb-Yjxf5PQuTgeeyECHK8BEYxWnHGNC-nbkoeItn9o1DEW986rxEh1k9Ii2ZzZ4IHogtgDBCdLfWCahmuvkiloo2vsJLBZCkdGU4oV154tlNyiG1K1CrRSBiZpTMj8gYjSX1TsSBm2Q6SSrU-f5LnKIxlFKoiauUOTmhHklDjTZgAv7OZkGVolm6buOfLoDPt501qHf1SMbIMuZRQnSsKS--zfafHNp7qbiLQCP90rPwONEYrG9zWxYEONYEEbrqbpaDp9iX5RwSmqcRj5pH-JoQQW62CQ_gq4roE46cN_thNPYqIuBf4LibCk4I4CXaE6oJxCrYJKIv-dxbk1qQDGwK133utAGCz2J-K3U3AJgVcSEqejqoQ&opi=122715837]]></IconClickThrough>
         </IconClicks>
        </Icon>
       </Icons>
       <MediaFiles>
        <MediaFile id="GDFP" delivery="progressive" width="640" height="360" type="video/mp4" bitrate="140" scalable="true" maintainAspectRatio="true"><![CDATA[https://redirector.gvt1.com/videoplayback/id/f1be9c477e89fd68/itag/18/source/dclk_video_ads/acao/yes/cpn/_fSzLXyEANrWd2Eh/ctier/L/ei/SuIQaPrvK-21svQP6tja8A4/ip/0.0.0.0/requiressl/yes/rqh/1/susc/dvc/xpc/Eghovf3BOnoBAQ%3D%3D/expire/1777472970/sparams/expire,ei,ip,requiressl,acao,ctier,source,id,itag,rqh,susc,xpc/sig/AJfQdSswRgIhAK4z6FsxRlYdwavFgN8cGCxj0X-XgS2lwNv_tS1REzRSAiEA0mVPU76kq002Fv1awyMgT3SzcqP9UG7gbGJzFWDwtk0%3D/file/file.mp4]]></MediaFile>
        <MediaFile id="GDFP" delivery="progressive" width="1280" height="720" type="video/mp4" bitrate="237" scalable="true" maintainAspectRatio="true"><![CDATA[https://redirector.gvt1.com/videoplayback/id/f1be9c477e89fd68/itag/22/source/dclk_video_ads/acao/yes/cpn/_fSzLXyEANrWd2Eh/ctier/L/ei/SuIQaPrvK-21svQP6tja8A4/ip/0.0.0.0/requiressl/yes/rqh/1/susc/dvc/xpc/Eghovf3BOnoBAQ%3D%3D/expire/1777472970/sparams/expire,ei,ip,source,id,itag,requiressl,acao,ctier,rqh,susc,xpc/sig/AJfQdSswRAIgEbCqF-wTm_cr8stoFxbakQhNKOytrslVL5cN5vCgowwCIF7bxI_vWtzsOvoC-FXVhw1g60Npq1mstULneL7h0p7Q/file/file.mp4]]></MediaFile>
        <MediaFile id="GDFP" delivery="progressive" width="1280" height="720" type="video/mp4" bitrate="259" scalable="true" maintainAspectRatio="true"><![CDATA[https://redirector.gvt1.com/videoplayback/id/f1be9c477e89fd68/itag/106/source/dclk_video_ads/acao/yes/cpn/_fSzLXyEANrWd2Eh/ctier/L/ei/SuIQaPrvK-21svQP6tja8A4/ip/0.0.0.0/requiressl/yes/rqh/1/susc/dvc/xpc/Eghovf3BOnoBAQ%3D%3D/expire/1777472970/sparams/expire,ei,ip,requiressl,acao,ctier,source,id,itag,rqh,susc,xpc/sig/AJfQdSswRQIhALtJ8cLzvdt2fqTIMWMQJrws9FQ7j50yPaM74ueshacEAiB-mPTkdo-3KtNCwM6zfhTUyMFDvsO1Lu69GQrBfJvaGA%3D%3D/file/file.mp4]]></MediaFile>
        <MediaFile id="GDFP" delivery="progressive" width="854" height="480" type="video/mp4" bitrate="183" scalable="true" maintainAspectRatio="true"><![CDATA[https://redirector.gvt1.com/videoplayback/id/f1be9c477e89fd68/itag/109/source/dclk_video_ads/acao/yes/cpn/_fSzLXyEANrWd2Eh/ctier/L/ei/SuIQaPrvK-21svQP6tja8A4/ip/0.0.0.0/requiressl/yes/rqh/1/susc/dvc/xpc/Eghovf3BOnoBAQ%3D%3D/expire/1777472970/sparams/expire,ei,ip,requiressl,acao,ctier,source,id,itag,rqh,susc,xpc/sig/AJfQdSswRQIgdH-k_I0lOuWSukSpsnVvt6Ux-EJptJtlp-hyKMC7dLICIQDN4dmUpgTR9CffT8BQDCbg7dBSPWmR8Pxd9yTh_6arjg%3D%3D/file/file.mp4]]></MediaFile>
        <MediaFile id="GDFP" delivery="streaming" width="256" height="144" type="application/x-mpegURL" minBitrate="96" maxBitrate="494" scalable="true" maintainAspectRatio="true"><![CDATA[https://redirector.gvt1.com/api/manifest/hls_variant/id/f1be9c477e89fd68/itag/0/source/dclk_video_ads/acao/yes/cpn/_fSzLXyEANrWd2Eh/ctier/L/ei/SuIQaPrvK-21svQP6tja8A4/hfr/all/ip/0.0.0.0/keepalive/yes/playlist_type/DVR/requiressl/yes/rqh/5/susc/dvc/xpc/Eghovf3BOnoBAQ%3D%3D/expire/1777472970/sparams/expire,ei,ip,hfr,requiressl,source,playlist_type,acao,ctier,id,itag,rqh,susc,xpc/sig/AJfQdSswRQIgSWk3e1B_CSvH6J0cI0qmIXLEKDMnI8Gb3rq7uhWyTyMCIQCb2v2oKdlQqiXqhpIS_5qutIVspYSzsrvIV8opqKNlqw%3D%3D/file/index.m3u8]]></MediaFile>
        <MediaFile id="GDFP" delivery="streaming" width="0" height="0" type="application/dash+xml" scalable="true" maintainAspectRatio="true"><![CDATA[https://redirector.gvt1.com/api/manifest/dash/id/f1be9c477e89fd68/itag/0/source/dclk_video_ads/acao/yes/cpn/_fSzLXyEANrWd2Eh/ctier/L/ei/SuIQaPrvK-21svQP6tja8A4/hfr/all/ip/0.0.0.0/keepalive/yes/playlist_type/DVR/requiressl/yes/rqh/2/susc/dvc/xpc/Eghovf3BOnoBAQ%3D%3D/expire/1777472970/sparams/expire,ei,ip,playlist_type,acao,ctier,id,itag,hfr,requiressl,source,rqh,susc,xpc/sig/AJfQdSswRQIgatLZIR1gnzt3dEDKVbhxhvh2Jd7M94E5gvV2OO9cQ0wCIQDhQqW--RhOAw5_BdYF6LAmCMQ7Gf2Z7089EaEEpuP3yQ%3D%3D/file/index.mpd]]></MediaFile>
       </MediaFiles>
      </Linear>
     </Creative>
     <Creative id="138381056765" sequence="1">
      <CompanionAds>
       <Companion id="138381056765" width="300" height="250">
        <StaticResource creativeType="image/png"><![CDATA[https://pagead2.googlesyndication.com/simgad/4446644594546952943]]></StaticResource>
        <TrackingEvents>
         <Tracking event="creativeView"><![CDATA[https://pagead2.googlesyndication.com/pcs/view?xai=AKAOjstc_5B2Cmmx7JoHt1xe-QsXFiISMFj2dOTYZlicu687YF-gC7JBGc5uDiNtn1Ir77hO_Ex7uiLf1PG0fv0PsyRUKMNbr4EvIpMv532nNfbfsT8AOtv4tR6wv9yP9K659k0iXCna5ABEFheOxdQddcxZgo5EVDYA3CFPAj5RDOWM3fxQ3SDaSa7CYU8UeuLOFVcD0XKVemhsSiNnyVdm7AVN8z40mOHAA2RcVL8IAJRsxCuwKd_m_wsCCSk5vuXMdXXyQUJH5usVpi-edOpea-K1GYIhuFolB7Vpw2uBdtRn6PWsC7LH9ylp41j0n94NUisc-FBI1RdFiwQaaVe6W4DRrL5A6mnPID7QlSpBymb8tez-oMVdRO2OGTMUebls4AtSKz6VN-KT&sig=Cg0ArKJSzGmY1MzNtXN9EAE&uach_m=%5BUACH%5D&adurl=]]></Tracking>
        </TrackingEvents>
        <CompanionClickThrough><![CDATA[https://pagead2.googlesyndication.com/pcs/click?xai=AKAOjsuPgM9N8cWIPKKgmboJNFGHomWhC2aVR1PsYSuCjRrwuzPTKE-JJdggAxMlG9KEhIX39gFf03Ownq0s4lM-BLINQ1rftqiUb940rEO__A-lCMpTYGXzxT7NOI7SWX8xaG_D8K7ub3JLaAyzTNRatekUjZ7DT6afqJnHUGJqB1E1ppqBR5oMFupfkXnPKhRuseVPqS_6e7RxQNGbevE9JY9VUKze_dNVwqU8FEYWWe28B-p14loE4ono4-G1VlkafrT1NXLIX_vy6TrXSQOho0xjsnWeLIVIefVFRdLF3evYOnBLMWkkFoeC7EUSjerLXhYgY5zEqp5MU9snbHt0PRl28z89For6lzP217WBKtXW5M0EG7moqvKct3k&sig=Cg0ArKJSzEYxck5RWJip&fbs_aeid=%5Bgw_fbsaeid%5D&adurl=https://googleads.github.io/googleads-ima-html5/vsi/]]></CompanionClickThrough>
       </Companion>
       <Companion id="138381188849" width="728" height="90">
        <StaticResource creativeType="image/png"><![CDATA[https://pagead2.googlesyndication.com/simgad/7802555171787573026]]></StaticResource>
        <TrackingEvents>
         <Tracking event="creativeView"><![CDATA[https://pagead2.googlesyndication.com/pcs/view?xai=AKAOjst1NrYL44vdhDZZaA8EiXnnUeKAEqiWRDc1gGU-JtI2VAv5C0jPMROD9m3aCspyZEvoOKMGJxtj_zl2zvEeVtnHHHtTqqLGwaeGQWC9ZIGEb5sKYlc6u7JTKmWVU6UXDC1FxR7xm1RNqOD5Fl3QbgoPpN_ktd0o2zTZiW2IJziQ8J-anWaNlUMmF16lXLoKl3kD8-syIGj8dIWWP1wNIlHYWSppThgAHHm9Z8uXKweaUnYTHaTUlbfgMSiGNxGL71-yc5OiQyh1_PXDS0I5PILOeppDfZEnDtOAXYWRPdnivd1tTQ-hTh18BXUcfCrOoWDjxFs0Xe28y7RHWdRl_C2VhH6dH-zsjr3QRtwZZhymukHeW5k-RL2mQK9MZ6ZPrxPTUPvnj_Au&sig=Cg0ArKJSzC5FLiD2Bch3EAE&uach_m=%5BUACH%5D&adurl=]]></Tracking>
        </TrackingEvents>
        <CompanionClickThrough><![CDATA[https://pagead2.googlesyndication.com/pcs/click?xai=AKAOjsvC4KR0_jwQMkltgX_naCTuRaU-uMZtq63TMprqKj-kL-tdZhU-kw_ar0Qh2OuEU53HYVFY0MtWOue5RB94dj3fG4ktYtVeha__wnVzfphSy-1Cirzdft3629ItihNpCHvTbZ1YfxZDf_T5YhKEujkYtimVTKJDFIsLIoEBs4db1eUPIvfEJH09b_RtM4CrHwcz_4CfXoG9wp768jKJeJaW3ZVtcUjqo4inM1P7U7TrvJgzv-KHnWfjdEUlUKXgVoJt88eq82fNZsen6BMgagTqu83kRNh5XEC0tWQbMclENpdf2pKRMlhjvyOH0nWsraTPT9iAOMJKEIWoaB1aVZW7gB1gW_yxQissmFTH2OOWIUWc_NB6ByH-Wm0&sig=Cg0ArKJSzNgIzfc_hoj4&fbs_aeid=%5Bgw_fbsaeid%5D&adurl=https://googleads.github.io/googleads-ima-html5/vsi/]]></CompanionClickThrough>
       </Companion>
      </CompanionAds>
     </Creative>
    </Creatives>
    <Extensions><Extension type="waterfall" fallback_index="0"/><Extension type="geo"><Country>NL</Country><Bandwidth>0</Bandwidth></Extension><Extension type="metrics"><FeEventId>SuIQaMaqKqWD1PIP-NPO4Ao</FeEventId><AdEventId>CJrKwYe6_YwDFXc7vwQd4AwzsQ</AdEventId></Extension><Extension type="ShowAdTracking"><CustomTracking><Tracking event="show_ad"><![CDATA[https://pagead2.googlesyndication.com/pcs/view?xai=AKAOjsvWPDNZUriJvTpGztZreJdv9IYN6sxE15K4PSWl5T66gpP46TTbBY7xG6LDhTzm9i87u5ltnwtajH6T-Cg7r7CGeWnU1gsJqYS4yMZfBhvO-HWti35DSvHhq9MqJnVOxmniFvfNtp1LIWQa6jtH3kwtfHuNfM_xV0CNidsZQmozVp3ImvNIXQgGch5xzwcNtT-dzPUCcHVF-kzgMM0RLJBjTPVqJSuu3W5_IANCOEn-3TtAkIWE1d_yBk0hblySSCsSpyIw7jq2hSbjqHyM-mJ_kQeje_aI4ePqptAxXRQmr-NSY_fUFW-n_DqhKOhjO6ONl_Xom9ah5fXRNrtTKNdqKGeDYTWnb5WNLMfYZNrPGNLnRCpdtM8ljmm9OdNhfOycO7RCXlO9MWc&sig=Cg0ArKJSzKh12huVKWgfEAE&uach_m=%5BUACH%5D&adurl=]]></Tracking></CustomTracking></Extension><Extension type="video_ad_loaded"><CustomTracking><Tracking event="loaded"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=video_ad_loaded]]></Tracking></CustomTracking></Extension><Extension type="esp"><EspLibrary LibraryName="uidapi.com" LibraryUrl=""/><EspLibrary LibraryName="euid.eu" LibraryUrl=""/><EspLibrary LibraryName="liveramp.com" LibraryUrl=""/><EspLibrary LibraryName="esp.criteo.com" LibraryUrl=""/><EspLibrary LibraryName="liveintent.com" LibraryUrl=""/><EspLibrary LibraryName="liveintent.triplelift.com" LibraryUrl=""/><EspLibrary LibraryName="id5-sync.com" LibraryUrl=""/><EspLibrary LibraryName="yahoo.com" LibraryUrl=""/><EspLibrary LibraryName="epsilon.com" LibraryUrl=""/><EspLibrary LibraryName="pubcid.org" LibraryUrl=""/><EspLibrary LibraryName="mygaruID" LibraryUrl=""/><EspLibrary LibraryName="justtag.com" LibraryUrl=""/><EspLibrary LibraryName="utiq.com" LibraryUrl=""/><EspLibrary LibraryName="audigent.com" LibraryUrl=""/><EspLibrary LibraryName="liveintent.indexexchange.com" LibraryUrl=""/><EspLibrary LibraryName="bidswitch.net" LibraryUrl=""/><EspLibrary LibraryName="pubmatic.com" LibraryUrl=""/><EspLibrary LibraryName="openx.net" LibraryUrl=""/><EspLibrary LibraryName="intentiq.com" LibraryUrl=""/><EspLibrary LibraryName="adserver.org" LibraryUrl=""/><EspLibrary LibraryName="rubiconproject.com" LibraryUrl=""/><EspLibrary LibraryName="intimatemerger.com" LibraryUrl=""/><EspLibrary LibraryName="ceeid.eu" LibraryUrl=""/><EspLibrary LibraryName="crwdcntrl.net" LibraryUrl=""/></Extension><Extension type="heavy_ad_intervention"><CustomTracking><Tracking event="heavy_ad_intervention_cpu"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=heavy_ad_intervention_cpu]]></Tracking><Tracking event="heavy_ad_intervention_network"><![CDATA[https://pagead2.googlesyndication.com/pagead/interaction/?ai=BoODGSuIQaJr9Kvf2_NUP4JnMiQuD6qWVRgAAABABII64hW84AViLgsbBgwRgkcSXhYAYugEKNzI4eDkwX3htbMgBBcACAuACAOoCJy8yMTc3NTc0NDkyMy9leHRlcm5hbC9zaW5nbGVfYWRfc2FtcGxlc_gC8NEegAMBkAPIBpgD4AOoAwHgBAHSBQYQj6XEiRagBiOoB7i-sQKoB_PRG6gHltgbqAeqm7ECqAfgvbECqAeaBqgH_56xAqgH35-xAqgH-MKxAqgH-8KxAtgHAeAHAdIILAiR4YBwEAEYHTIF64uAgCA6DIBAgICAgICUruADIEi9_cE6WJGZwYe6_YwD2AgCgAoFmAsBqg0CTkzqDRMIw5LCh7r9jAMVdzu_BB3gDDOx8A0B0BUB-BYBgBcB&sigh=elGxVUvGK8o&label=heavy_ad_intervention_network]]></Tracking></CustomTracking></Extension><Extension type="IconClickFallbackImages"><IconClickFallbackImages program="GoogleWhyThisAd"><IconClickFallbackImage width="1920" height="1080"><AltText>Why this ad? This ad is based on: * General factors like the app you&#39;re using, the time of day, or your approximate location. You can update your options for ads in this device&#39;s settings.</AltText><StaticResource creativeType="image/png"><![CDATA[https://pubads.g.doubleclick.net/ata-qr?url=aHR0cHM6Ly9hZHNzZXR0aW5ncy5nb29nbGUuY29tL3doeXRoaXNhZD9zb3VyY2U9ZGlzcGxheSZyZWFzb25zPUFkaEhKRVRRdUE0dzBzSUI4S1J3MlFUZGhJWTgtUjBGNWlDRElad003dHdDMHVLbFBSVkRRVlFRQXRyNGtOQ3E4S29ZOWVkSGRDUUhScXBOYWw0Z1VmRWJaVWpudlQwZV83R2VnZ1JCT0Zfek11TXg3YlR5Yy1NamM5c0Q0ZllTdkxDZ3kzYk1ieFdYSUpELUlNYVBJNVRnd1pWTEkzOUwyNWxmaGVuWkdPU2ZZeUw1ZnV0SjNJNGY1aWlWT04yWEFleUlLcEIyNDlMQnVmR2ZvUWFXSmoxWHI2Q3FqMG1hNDdIYmNId2JyMS1ibVgtV0pfay1aVl9XQ0J6WkVKRHhtcDJIa2R1VEd6cWVXWDFxeS1Gby1ScVpPbEJjNWR3MFdTbzJaRGYtZ1poQTA0M0RhSUx2Mjl5WHRlaEhPaFJVb25MV1FRa1pTVFNiSEZ0ZkJRLUV6cFB2aTBfMVB5RmxGMnhGUXh5NTZ1b2RPa0gyYS1ZUFpQZENsQ2s1RGNIbERqVnpKeWg4cGZVbHdNcHlPYTNCTTdVUDQ3Z21JbmctZ0tYSS1FeFdQWTh0LUJma002S25nZlpfWTlFRTFOYnJNUHpfN2F6QzlQdWx6MDdTdUZ1UEw0TkNVd05vM0VrMzExd0VNUm00bmoxRUpoMVk4SnNwTmd4Y0h3MC14SWItWWp4ZjVQUXVUZ2VleUVDSEs4QkVZeFduSEdOQy1uYmtvZUl0bjlvMURFVzk4NnJ4RWgxazlJaTJaelo0SUhvZ3RnREJDZExmV0NhaG11dmtpbG9vMnZzSkxCWkNrZEdVNG9WMTU0dGxOeWlHMUsxQ3JSU0JpWnBUTWo4Z1lqU1gxVHNTQm0yUTZTU3JVLWY1TG5LSXhsRktvaWF1VU9UbWhIa2xEalRaZ0F2N09aa0dWb2xtNmJ1T2ZMb0RQdDUwMXFIZjFTTWJJTXVaUlFuU3NLUy0temZhZkhOcDdxYmlMUUNQOTByUHdPTkVZckc5eld4WUVPTllFRWJycWJwYURwOWlYNVJ3U21xY1JqNXBILUpvUVFXNjJDUV9ncTRyb0U0NmNOX3RoTlBZcUl1QmY0TGliQ2s0STRDWGFFNm9KeENyWUpLSXYtZHhiazFxUURHd0sxMzN1dEFHQ3oySi1LM1UzQUpnVmNTRXFlanFvUSZvcGk9MTIyNzE1ODM3&hl=en&wp=ca-pub-9939518381636264&p=1&gqi=SuIQaMaqKqWD1PIP-NPO4Ao]]></StaticResource></IconClickFallbackImage></IconClickFallbackImages></Extension><Extension type="companion_about_this_ad"><Icon program="GoogleWhyThisAd" width="18" height="18" xPosition="right" yPosition="bottom"><StaticResource creativeType="image/png"><![CDATA[https://imasdk.googleapis.com/formats/wta/help_outline_white_24dp_with_3px_trbl_padding.png?wp=ca-pub-9939518381636264]]></StaticResource><IconClicks><IconClickThrough><![CDATA[https://adssettings.google.com/whythisad?source=display&reasons=AdhHJEQdppAbykkOyYmEWDs6DfL_QBzN-nDKypG_VkSgqArGTP9CNAi57wafQJQ6UFnHFIpUK2_0HI2exJiHw7oxoz0RSjRDIWvKy4dWWn6G4b7lgoGxrvTdqeHlXzyjVoaKiye9chipViOjSOTLxFKTbiY7sJiKkbXNb3iN0lFCA6Es32apXWwLZy95VwnvWzNh9Wamf9dh2lr3HE59OzzcpyPrZwiIq84Ok0vWrsSgkE72JIQJy4zn4GQwGwAZeeBct8wA_OC7jo3U8GTYSVPJO5lIBBOZCgliFVrAVoeFasRTWU_9nmF5KePIXLhW2FKGMd-KiVVxojs9uqs37i8eDVCJP-u2yeo-1QWFNZ3HomGdEIvv50xvl2iVoxyf8FNdSE4grhuVK5JFaUTyQ8aunoC69TKfJkKRFVlw6Okh9QD2k7AwVDQwbW1IABEwHp7ZLRd9LuPSu6XWcdmESkQarg0gmmak8HDX69m_xhdYdlVKz23cZpoL83Qgu403z8VPO4cO6MIMYVVCFeJ3lP4spMejrs7z9BjfcQmpHYmXSNDi9mzmiA4M3X8gt5DJ1EY8X01Orw7mdexWGqRaTz7-b0FOMpBSYjAc6Rz8M5Tr6Ihi9gsGle7suQDyfng4eYAEViAlO17WAHX3A1cgOSPNcHqSF_GHDxGc8up49gll11ADxtwrZMIZwv2WUl5tJc48rJPkvTRZYLHZMrMKS5egnEZfC4CNsLhgrdjXfXZv1tiv8jCnwg0NFwkhaFWNHRLg-uhPt2eQcAUx5LkqCmJyx6vofxoRXsW7jXJmevMzppU8hraXAm8QHtweasUFLwDYngBER8JP1WcyVCP2uDKv2w8jCrtyJIvQzsi6OGH-bTShdw&opi=122715837]]></IconClickThrough><IconClickFallbackImages><IconClickFallbackImage width="640" height="226"><AltText>Why this ad? This ad is based on: * General factors like the app you're using, the time of day, or your approximate location. You can update your options for ads in this device's settings.</AltText><StaticResource creativeType="image/png"><![CDATA[https://imasdk.googleapis.com/formats/wta/contextual_bks.png?wp=ca-pub-9939518381636264]]></StaticResource></IconClickFallbackImage></IconClickFallbackImages></IconClicks></Icon></Extension></Extensions>
   </InLine>
  </Ad>
 </VAST>
"""
    }
}
