//
//  PlayerView.swift
//  rotation
//
//  Created by Yura on 4/22/23.
//

import SwiftUI
import AVKit

@available(iOS 15.0, *)
struct PlayerView: View {
    @State var angle = Angle(degrees: 0)
    @State var size = CGSize(width: 375, height: 211)
    @State var yOffset = 0.0
    
    let originalSize = CGSize(width: 375, height: 211)
    let fullscreenSize = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
    
    let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    
    var expand: ((Bool) -> Void)?
    
    @Namespace var animation
    
    @State var fullscreen = false
    
    var body: some View {
        CustomVideoPlayer(player: self.player, size: self.$size)
            .frame(maxWidth: self.size.width, maxHeight: self.size.height)
            .rotationEffect(self.angle, anchor: self.angle == .degrees(90) ? .topTrailing : .bottomTrailing)
            .onAppear() {
                self.player.play()
            }
            .onDisappear() {
                self.player.pause()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    switch UIDevice.current.orientation {
                    case .landscapeLeft:
                        self.size = self.fullscreenSize
                        self.angle = .degrees(90)
                        self.yOffset = 175
                        
                        self.fullscreen = true
                    case .landscapeRight:
                        self.size = self.fullscreenSize
                        self.angle = .degrees(-90)
                        self.yOffset = -175
                        
                        self.fullscreen = true
                    default:
                        self.size = self.originalSize
                        self.angle = .degrees(0)
                        self.yOffset = 0
                    }
                }
            }
            .offset(y: self.yOffset)
            .onTapGesture {
                self.fullscreen.toggle()
            }
            .onChange(of: self.fullscreen) {
                self.expand?($0)
            }
    }
}

@available(iOS 15.0, *)
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerView()
            
            PlayerView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
