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
    @State var size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 9 / 16)
    
    @State var yOffset = 0.0
    @State var xOffset = 0.0
    
    let originalSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 9 / 16)
    let fullscreenSize = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
    
    let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    
    let shuttle = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
    let bunny = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    
    let topViewHeight: CGFloat
    let bottomViewHeight: CGFloat
    
    var expand: ((Bool) -> Void)?
    
    @Namespace var animation
    
    @State var fullscreen = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { geometry in
                CustomVideoPlayer(player: self.player, size: self.$size)
                    .aspectRatio(16 / 9, contentMode: .fit)
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
                                self.size = CGSize(width: self.originalSize.width * 16 / 9, height: self.originalSize.width) /// 16:9
                                
                                self.yOffset = -(self.originalSize.width - self.originalSize.height) / 2
                                
                                print("left")
                                
                                self.fullscreen = true
                            case .landscapeRight:
                                self.angle = .degrees(-90)
                                self.size = CGSize(width: self.originalSize.width * 16 / 9, height: self.originalSize.width) /// 16:9
                                
                                self.xOffset = -(188.68 + 75.35)
                                self.yOffset = -(self.originalSize.width - self.originalSize.height) / 2
                                
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
                    .overlay(alignment: .bottomTrailing) {
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
        .frame(maxWidth: self.size.width, maxHeight: self.size.height)
        .border(.yellow)
    }
}

@available(iOS 15.0, *)
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerView(topViewHeight: 100, bottomViewHeight: 500)
            
            PlayerView(topViewHeight: 100, bottomViewHeight: 500)
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
