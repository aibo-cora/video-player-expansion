//
//  CustomVideoPlayer.swift
//  rotation
//
//  Created by Yura on 4/21/23.
//

import Foundation
import AVKit
import UIKit
import SwiftUI
import Combine

struct CustomVideoPlayer: UIViewRepresentable {
    let player: AVPlayer
    
    @Binding var size: CGSize
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let layer = AVPlayerLayer(player: self.player)
        
        view.backgroundColor = .systemBackground
        view.layer.addSublayer(layer)
        
        layer.frame = CGRect(origin: .zero, size: self.size)
        layer.videoGravity = .resizeAspect
        
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        for layer in uiView.layer.sublayers ?? [] {
            if layer is AVPlayerLayer {
                layer.frame = CGRect(origin: .zero, size: self.size)
            }
        }
    }
}
