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
    @State var xOffset = 0.0
    
    let originalSize = CGSize(width: 375, height: 211)
    let fullscreenSize = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
    
    let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    
    var expand: ((Bool) -> Void)?
    
    @Namespace var animation
    
    @State var fullscreen = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { geometry in
                CustomVideoPlayer(player: self.player, size: self.$size)
                    .offset(x: self.xOffset, y: self.yOffset)
                    .frame(maxWidth: self.size.width, maxHeight: self.size.height)
                    .rotationEffect(self.angle)
                    .border(.white)
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
                                self.angle = .degrees(90)
                                self.size = self.fullscreenSize
                                
                                self.xOffset = -(self.fullscreenSize.width - geometry.size.height) / 2
                                
                                print("left")
                                
                                self.fullscreen = true
                            case .landscapeRight:
                                self.angle = .degrees(-90)
                                self.size = self.fullscreenSize
                                
                                self.xOffset = -self.fullscreenSize.width / 2
                                
                                print("right")
                                
                                self.fullscreen = true
                            case .portrait:
                                self.angle = .degrees(0)
                                self.size = self.originalSize
                                
                                self.yOffset = 0
                                self.xOffset = 0
                            default:
                                break
                            }
                        }
                    }
                    .onChange(of: self.fullscreen) {
                        self.expand?($0)
                    }
                    .onAppear() {
                        print(geometry.size, self.fullscreenSize)
                    }
            }
            
            Button {
                self.fullscreen.toggle()
            } label: {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .frame(maxWidth: 50, maxHeight: 50)
            }
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
