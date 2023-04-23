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
    @State var xOffset = 0.0
    @State var yOffset = 0.0
    
    let original = CGSize(width: 375, height: 211)
    let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    
    var completion: ((UIDeviceOrientation) -> Void)?
    
    @Namespace var animation
    
    @State var fullscreen = false
    
    var body: some View {
        GeometryReader { geometry in
            CustomVideoPlayer(player: self.player, size: self.$size)
                .frame(maxWidth: self.size.width, maxHeight: self.size.height)
                .rotationEffect(self.angle, anchor: .center)
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
                            self.size = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
                            self.angle = .degrees(90)
                            print("left")
                        case .landscapeRight:
                            self.size = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
                            self.angle = .degrees(-90)
                            self.yOffset = UIScreen.main.bounds.height / 2
                            print("right")
                        default:
                            self.size = self.original
                            self.angle = .degrees(0)
                            self.xOffset = 0
                            self.yOffset = 0
                        }
                    }
                }
                .offset(x: self.xOffset)
                .offset(y: self.yOffset)
                .overlay(alignment: Alignment.bottomTrailing, content: {
                    Button {
                        self.fullscreen.toggle()
                    } label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    .padding(.horizontal)
                })
                .onTapGesture {
                    print("tapped")
                }
                .onAppear() {
                    print("geometry=\(geometry.size)")
                }
        }
    }
}

@available(iOS 15.0, *)
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
