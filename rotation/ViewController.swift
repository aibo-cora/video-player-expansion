//
//  ViewController.swift
//  rotation
//
//  Created by Yura on 4/21/23.
//

import UIKit
import SwiftUI
import AVFoundation
import Combine

@available(iOS 15.0, *)
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.configureUI()
    }
    
    var host: UIHostingController<PlayerView>?

    func configureUI() {
        self.view.backgroundColor = .clear
        
        let label = UILabel(frame: .zero)
        let header = UILabel(frame: .zero)
        let foundation = UIView(frame: .infinite)
        
        let screenWidth = self.view.window?.windowScene?.screen.bounds.width ?? 0
        
        let topViewHeight: CGFloat = 200
        let bottomViewHeight: CGFloat = 400
        
        let root = PlayerView(topViewHeight: topViewHeight, bottomViewHeight: bottomViewHeight) {
            if $0 {
                self.host?.view.layer.zPosition = 2
                /// Show player's background.
                foundation.layer.zPosition = 0
                foundation.isHidden = false
            } else {
                self.host?.view.layer.zPosition = 0
                
                if let host = self.host {
                    pinToParent(child: host.view)
                }
                /// Hide player's background.
                foundation.layer.zPosition = 0
                foundation.isHidden = true
            }
        }
        ///
        let controller = UIHostingController(rootView: root)
        
        controller.view.backgroundColor = .black
        controller.view.layer.zPosition = 0
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.host = controller
        
        self.view.addSubview(label)
        self.view.addSubview(header)
        self.view.addSubview(foundation)
        
        self.view.addSubview(controller.view)
        ///
        header.text = "Header..."
        header.translatesAutoresizingMaskIntoConstraints = false
        header.textAlignment = .center
        header.textColor = .black
        header.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.view.topAnchor),
            header.bottomAnchor.constraint(equalTo: controller.view.topAnchor),
            header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: topViewHeight)
        ])
        pinToParent(child: controller.view)
        ///
        func pinToParent(child: UIView) {
            NSLayoutConstraint.activate([
                child.topAnchor.constraint(equalTo: header.bottomAnchor),
                child.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                child.heightAnchor.constraint(equalToConstant: screenWidth * 9 / 16)
            ])
        }
        ///
        label.text = "Testing..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            label.topAnchor.constraint(equalTo: controller.view.bottomAnchor)
        ])
        ///
        foundation.backgroundColor = .black
        foundation.isHidden = true
    }
    
    var orientation: UIDeviceOrientation?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}

