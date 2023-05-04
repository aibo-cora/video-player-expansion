//
//  TestAlignment.swift
//  rotation
//
//  Created by Yura on 4/23/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct TestAlignment: View {
    var body: some View {
        Rectangle()
            .ignoresSafeArea()
            .overlay {
                VStack {
                    HStack {
                        Text("Adventures of the Big Bunny")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation {
                                
                            }
                        } label: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(width: 50, height: 50)
                    }
                    .frame(maxWidth: .infinity, alignment: .bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
    }
}

@available(iOS 15.0, *)
struct TestAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TestAlignment()
    }
}
