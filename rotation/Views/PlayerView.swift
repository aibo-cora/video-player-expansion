//
//  PlayerView.swift
//  rotation
//
//  Created by Yura on 4/22/23.
//

import SwiftUI
import AVKit

@available(iOS 14.0, *)
struct PlayerView: View {
    @State var orientation: UIDeviceOrientation?
    
    let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    
    var completion: ((UIDeviceOrientation) -> Void)?
    
    var body: some View {
        ZStack {
            Color.clear
            
            GeometryReader { geometry in
                CustomVideoPlayer(player: self.player, size: geometry.size)
                    .onAppear() {
                        self.player.play()
                    }
                    .onDisappear() {
                        self.player.pause()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        let orientation = UIDevice.current.orientation
                        
                        self.completion?(orientation)
                        self.orientation = orientation
                    }
            }
        }
    }
}
