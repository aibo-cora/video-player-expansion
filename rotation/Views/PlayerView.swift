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
    
    @State var pxOffset = 0.0
    @State var pyOffset = 0.0
    
    @State var cxOffset = 0.0
    @State var cyOffset = 0.0
    
    @State var orientation: UIDeviceOrientation = .unknown
    
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
        GeometryReader { geometry in
            CustomVideoPlayer(player: self.player, size: self.$size)
                .offset(x: self.pxOffset, y: self.pyOffset)
                .frame(maxWidth: self.size.width, maxHeight: self.size.height)
                .rotationEffect(self.angle)
                .onAppear() {
                    self.player.play()
                    
                }
                .onDisappear() {
                    self.player.pause()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        let playerWidthFullscreen = self.originalSize.width * 16 / 9
                        let playerHeightFullscreen = self.originalSize.width
                        
                        let buffer = self.fullscreenSize.width - playerWidthFullscreen /// Space not occupied by player.
                        let playerFullscreenSize = CGSize(width: playerWidthFullscreen, height: playerHeightFullscreen) /// 16:9
                        let flap = (self.originalSize.width - self.originalSize.height) / 2
                        
                        self.orientation = UIDevice.current.orientation
                        
                        switch self.orientation {
                        case .landscapeLeft:
                            self.angle = .degrees(90)
                            self.size = playerFullscreenSize
                            
                            let xCoordinate = self.topViewHeight - flap
                            let offset = xCoordinate - buffer / 2
                            
                            self.pxOffset = -offset
                            self.pyOffset = -flap
                            
                            print("left")
                            
                            self.fullscreen = true
                        case .landscapeRight:
                            self.angle = .degrees(-90)
                            self.size = playerFullscreenSize
                            
                            let playerOffset = self.topViewHeight + self.originalSize.height + (self.originalSize.width - self.originalSize.height) / 2
                            
                            //self.pxOffset = -(playerWidthFullscreen - playerOffset + buffer / 2)
                            //self.pyOffset = -flap
                            
                            print("right")
                            
                            self.fullscreen = true
                        case .portrait:
                            self.changePlayerTransformWithOffsets(x: 0, y: 0)
                        default:
                            break
                        }
                    }
                }
                .onChange(of: self.fullscreen) { fullscreen in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.expand?(fullscreen)
                        
                        if !fullscreen {
                            self.changePlayerTransformWithOffsets(x: 0, y: 0)
                        }
                    }
                }
                .overlay {
                    VStack {
                        HStack {
                            Text("Adventures of the Big Bunny")
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .top)
                        
                        Spacer()
                        HStack {
                            Button {
                                print("play")
                            } label: {
                                Image(systemName: "play.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(width: 40, height: 40)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                        
                        Spacer()
                        
                        HStack {
                            Button {
                                print("play")
                            } label: {
                                Image(systemName: "play.fill")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(width: 40, height: 40)
                            
                            Spacer()
                            
                            Button {
                                self.fullscreen.toggle()
                                
                                withAnimation {
                                    if self.fullscreen {
                                        self.centerPlayer()
                                    }
                                }
                            } label: {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(width: 40, height: 40)
                            .padding([.trailing, .bottom])
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .bottom)
                    }
                    .rotationEffect(self.angle)
                }
        }
        .onAppear() {
            print(self.size)
        }
        .frame(maxWidth: self.size.width, maxHeight: self.size.height)
        .border(.yellow)
    }
    
    struct Controls: View {
        var body: some View {
            Text("")
        }
    }
    
    func centerPlayer() {
        let center = self.fullscreenSize.width / 2
        let yPosition = self.topViewHeight + self.originalSize.height / 2
        
        if yPosition < center {
            self.changePlayerTransformWithOffsets(x: 0, y: center - yPosition)
        } else {
            self.changePlayerTransformWithOffsets(x: 0, y: yPosition - center)
        }
    }
    
    func changePlayerTransformWithOffsets(x: CGFloat, y: CGFloat) {
        self.angle = .degrees(0)
        self.size = self.originalSize
        
        self.pxOffset = x
        self.pyOffset = y
    }
}

@available(iOS 15.0, *)
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerView(topViewHeight: 100, bottomViewHeight: 500)
        }
    }
}
