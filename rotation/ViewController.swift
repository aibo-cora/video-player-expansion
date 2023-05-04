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
        
        let screenWidth = self.view.window?.windowScene?.screen.bounds.width ?? 0
        let screenHeight = self.view.window?.windowScene?.screen.bounds.height ?? 0
        
        let label = UILabel(frame: .zero)
        let header = UILabel(frame: .zero)
        let foundation = UIView(frame: CGRect(origin: .zero, size: CGSize(width: screenWidth, height: screenHeight)))
        
        let topViewHeight: CGFloat = 200
        let bottomViewHeight: CGFloat = 400
        
        let root = PlayerView(topViewHeight: topViewHeight, bottomViewHeight: bottomViewHeight) {
            if let host = self.host {
                if $0 {
                    self.view.sendSubviewToBack(label)
                    self.view.sendSubviewToBack(header)
                } else {
                    self.view.bringSubviewToFront(label)
                    self.view.bringSubviewToFront(header)
                }
            }
        }
        ///
        let controller = UIHostingController(rootView: root)
        
        controller.view.backgroundColor = .black
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.host = controller
        
        self.view.addSubview(label)
        self.view.addSubview(header)
        self.view.addSubview(foundation)
        
        foundation.addSubview(controller.view)
        
        self.view.bringSubviewToFront(label)
        self.view.bringSubviewToFront(header)
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
        pin(child: controller.view, to: foundation)
        ///
        func pin(child: UIView, to parent: UIView) {
            NSLayoutConstraint.activate([
                child.topAnchor.constraint(equalTo: parent.topAnchor, constant: topViewHeight),
                child.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
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
    }
    
    var orientation: UIDeviceOrientation?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}

