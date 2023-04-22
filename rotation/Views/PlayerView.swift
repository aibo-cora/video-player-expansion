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
    @State var angle = Angle(degrees: 0)
    @State var size = CGSize(width: 375, height: 211)
    @State var xOffset = 0.0
    @State var yOffset = 0.0
    
    let original = CGSize(width: 375, height: 211)
    let parent: UIView
    let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    
    var completion: ((UIDeviceOrientation) -> Void)?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
            
            CustomVideoPlayer(player: self.player, size: self.$size)
                .rotationEffect(self.angle, anchor: .center)
                .onAppear() {
                    self.player.play()
                }
                .onDisappear() {
                    self.player.pause()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    let orientation = UIDevice.current.orientation
                    
                    switch orientation {
                    case .landscapeLeft:
                        self.size = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
                        self.angle = .degrees(90)
                        self.xOffset = UIScreen.main.bounds.width
                        self.yOffset = -30
                        
                        print("landscape left")
                    case .landscapeRight:
                        self.size = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
                        self.angle = .degrees(-90)
                        self.yOffset = UIScreen.main.bounds.height - 30
                        
                        print("landscape right")
                    default:
                        self.size = self.original
                        self.angle = .degrees(0)
                        self.xOffset = 0
                        self.yOffset = 0
                    }
                }
                .animation(.easeIn(duration: 0.25), value: self.angle)
                .offset(x: self.xOffset)
                .offset(y: self.yOffset)
        }
    }
}
