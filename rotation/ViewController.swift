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
        
        let topViewHeight: CGFloat = 201
        let bottomViewHeight: CGFloat = 400
        
        let root = PlayerView(topViewHeight: topViewHeight, bottomViewHeight: bottomViewHeight) {
            print("fullscreen=\($0)")
            
            if $0 {
                self.host?.view.layer.zPosition = 2
            } else {
                self.host?.view.layer.zPosition = 0
                
                if let host = self.host {
                    pinToParent(child: host.view)
                }
            }
        }
        ///
        let controller = UIHostingController(rootView: root)
        
        controller.view.backgroundColor = .yellow
        controller.view.layer.zPosition = 0
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.host = controller
        
        self.view.addSubview(controller.view)
        self.view.addSubview(label)
        self.view.addSubview(header)
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
                child.bottomAnchor.constraint(equalTo: label.topAnchor),
                child.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
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
            label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            label.heightAnchor.constraint(equalToConstant: bottomViewHeight)
        ])
        
    }
    
    var orientation: UIDeviceOrientation?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}

