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

@available(iOS 14.0, *)
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.configureUI()
    }
    
    var host: UIHostingController<PlayerView>?

    func configureUI() {
        let root = PlayerView() { self.rotate(orientation: $0) }
        let controller = UIHostingController(rootView: root)
        
        self.host = controller
        
        self.view.addSubview(controller.view)
        self.view.backgroundColor = .clear
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let guide = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: guide.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            controller.view.heightAnchor.constraint(equalToConstant: (self.view.window?.windowScene?.screen.bounds.width ?? 0) / 16 * 9),
        ])
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
    
    func rotate(orientation: UIDeviceOrientation) {
        let screenWidth = self.view.window?.windowScene?.screen.bounds.width ?? 0
        let screenHeight = self.view.window?.windowScene?.screen.bounds.height ?? 0
        
        let playerWidth = screenWidth
        let playerHeight = screenWidth / 16 * 9
        
        print("orientation=\(orientation.rawValue), player width=\(playerWidth), player height=\(playerHeight)")
        
        if let controller = self.host {
            switch orientation {
            case .landscapeLeft:
                UIView.animate(withDuration: 0.25) {
                    controller.view.frame = CGRect(x: screenWidth, y: screenWidth, width: screenHeight, height: screenWidth)
                    print("landscape left, frame=\(controller.view.frame)")
                    self.orientation = .landscapeLeft
                }
            case .landscapeRight:
                UIView.animate(withDuration: 0.25) {
                    controller.view.layer.zPosition = 1
                    controller.view.transform = CGAffineTransformMakeRotation(-.pi / 2)
                    controller.view.frame = CGRect(x: 0, y: screenHeight, width: screenHeight, height: screenWidth)
                    print("landscape right, frame=\(controller.view.frame), rotation= -90")
                    
                    self.orientation = .landscapeRight
                }
            default:
                UIView.animate(withDuration: 0.25) {
                    controller.view.layer.zPosition = 0
                    controller.view.transform = CGAffineTransformMakeRotation(0)
                    controller.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
                }
            }
        }
    }
    
    var orientation: UIDeviceOrientation?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}

