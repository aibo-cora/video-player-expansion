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
        ///
        let headerRegularHeight: NSLayoutConstraint = header.heightAnchor.constraint(equalToConstant: topViewHeight)
        let headerFullscreenHeight: NSLayoutConstraint = header.heightAnchor.constraint(equalToConstant: 0)
        
        headerRegularHeight.priority = UILayoutPriority(999)
        headerFullscreenHeight.priority = UILayoutPriority(998)
        ///
        let labelRegularHeight = label.heightAnchor.constraint(equalToConstant: bottomViewHeight)
        let labelFullscreenHeight = label.heightAnchor.constraint(equalToConstant: 0)
        
        labelRegularHeight.priority = UILayoutPriority(999)
        labelFullscreenHeight.priority = UILayoutPriority(998)
        ///
        let root = PlayerView(topViewHeight: topViewHeight, bottomViewHeight: bottomViewHeight) {
            if $0 {
                headerFullscreenHeight.priority = UILayoutPriority(1000)
                ///
                labelFullscreenHeight.priority = UILayoutPriority(1000)
            } else {
                headerFullscreenHeight.priority = UILayoutPriority(998)
                ///
                labelFullscreenHeight.priority = UILayoutPriority(998)
            }
        }
        
        let controller = UIHostingController(rootView: root)
        
        controller.view.backgroundColor = .black
        controller.view.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(foundation)
        self.view.addSubview(header)
        self.view.addSubview(label)
        self.view.addSubview(controller.view)
        ///
        
        header.text = "Header..."
        header.translatesAutoresizingMaskIntoConstraints = false
        header.textAlignment = .center
        header.textColor = .black
        header.backgroundColor = .white
        ///
        label.text = "Testing..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        ///
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.view.topAnchor),
            header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerRegularHeight,
            headerFullscreenHeight
        ])
        /// -
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: header.bottomAnchor),
            controller.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: label.topAnchor)
        ])
        /// -
        NSLayoutConstraint.activate([
            labelRegularHeight,
            labelFullscreenHeight,
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
        ///
        foundation.backgroundColor = .gray
    }
    
    var orientation: UIDeviceOrientation?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}

