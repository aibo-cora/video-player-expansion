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
    
    var playerTopRegularHeight: NSLayoutConstraint!
    var playerTopFullscreenHeight: NSLayoutConstraint!
    
    var playerRegularHeight: NSLayoutConstraint!
    var playerFullscreenHeight: NSLayoutConstraint!
    
    var playerFullScreenTopConstraint: NSLayoutConstraint!
    var playerFullScreenBottomConstraint: NSLayoutConstraint!

    func configureUI() {
        self.view.backgroundColor = .clear
        
        let screenWidth = self.view.window?.windowScene?.screen.bounds.width ?? 0
        let screenHeight = self.view.window?.windowScene?.screen.bounds.height ?? 0
        
        let label = UILabel(frame: .zero)
        let header = UILabel(frame: .zero)
        let foundation = UIView(frame: CGRect(origin: .zero, size: CGSize(width: screenWidth, height: screenHeight)))
        
        let topViewHeight: CGFloat = 200
        let bottomViewHeight: CGFloat = 400
        
        let headerRegularHeight: NSLayoutConstraint = header.heightAnchor.constraint(equalToConstant: topViewHeight)
        let headerFullscreenHeight: NSLayoutConstraint = header.heightAnchor.constraint(equalToConstant: 0)
        
        headerRegularHeight.priority = UILayoutPriority(999)
        headerFullscreenHeight.priority = UILayoutPriority(998)
        
        let root = PlayerView(topViewHeight: topViewHeight, bottomViewHeight: bottomViewHeight) {
            if $0 {
                headerFullscreenHeight.priority = UILayoutPriority(1000)
                ///
                self.playerFullscreenHeight.priority = UILayoutPriority(1000)
                self.playerRegularHeight.priority = UILayoutPriority(998)
            } else {
                headerFullscreenHeight.priority = UILayoutPriority(998)
                ///
                self.playerRegularHeight.priority = UILayoutPriority(1000)
                self.playerTopFullscreenHeight.priority = UILayoutPriority(998)
            }
        }
        
        let controller = UIHostingController(rootView: root)
        
        controller.view.backgroundColor = .black
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        /// Player - top.
        self.playerTopRegularHeight = controller.view.topAnchor.constraint(equalTo: foundation.topAnchor, constant: topViewHeight)
        self.playerTopFullscreenHeight = controller.view.topAnchor.constraint(equalTo: foundation.topAnchor, constant: 0)
        
        self.playerTopRegularHeight.priority = UILayoutPriority(999)
        self.playerTopFullscreenHeight.priority = UILayoutPriority(998)
        /// Player - height.
        self.playerRegularHeight = controller.view.heightAnchor.constraint(equalToConstant: screenWidth * 9 / 16)
        self.playerFullscreenHeight = controller.view.heightAnchor.constraint(equalToConstant: screenWidth * 16 / 9)
        
        self.playerRegularHeight.priority = UILayoutPriority(999)
        self.playerFullscreenHeight.priority = UILayoutPriority(998)
        
        let flap = (screenHeight - screenWidth * 16 / 9) / 2
        self.playerFullScreenTopConstraint = controller.view.topAnchor.constraint(equalTo: foundation.topAnchor, constant: 0)
        self.playerFullScreenBottomConstraint = controller.view.bottomAnchor.constraint(equalTo: foundation.bottomAnchor, constant: 0)
        
        self.playerFullScreenTopConstraint.priority = UILayoutPriority(999)
        self.playerFullScreenBottomConstraint.priority = UILayoutPriority(999)
        ///
        self.host = controller
        
        // self.view.addSubview(label)
        
        self.view.addSubview(foundation)
        self.view.addSubview(header)
        foundation.addSubview(controller.view)
        ///
        
        header.text = "Header..."
        header.translatesAutoresizingMaskIntoConstraints = false
        header.textAlignment = .center
        header.textColor = .black
        header.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.view.topAnchor),
            header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerRegularHeight,
            headerFullscreenHeight
        ])
        pin(child: controller.view, to: foundation)
        ///
        func pin(child: UIView, to parent: UIView) {
            NSLayoutConstraint.activate([
                playerTopRegularHeight,
                playerTopFullscreenHeight,
                child.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
                playerRegularHeight,
                playerFullScreenTopConstraint,
                playerFullScreenBottomConstraint
            ])
        }
        
        ///
        label.text = "Testing..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        
//        NSLayoutConstraint.activate([
//            label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
//            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            label.topAnchor.constraint(equalTo: controller.view.bottomAnchor)
//        ])
        ///
        foundation.backgroundColor = .gray
    }
    
    var orientation: UIDeviceOrientation?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}

