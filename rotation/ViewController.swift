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
        
        let root = PlayerView {
            print("fullscreen=\($0)")
            
            if $0 {
                self.host?.view.layer.zPosition = 2
            } else {
                self.host?.view.layer.zPosition = 0
            }
        }
        ///
        let controller = UIHostingController(rootView: root)
        
        controller.view.layer.zPosition = 0
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.host = controller
        self.view.addSubview(controller.view)
        pinToParent(child: controller.view)
        ///
        func pinToParent(child: UIView) {
            NSLayoutConstraint.activate([
                child.topAnchor.constraint(equalTo: self.view.topAnchor),
                child.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                child.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
        ///
        let label = UILabel(frame: .zero)
        
        self.view.addSubview(label)
        
        label.text = "Testing..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            label.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    var orientation: UIDeviceOrientation?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}

