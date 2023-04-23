//
//  TestAlignment.swift
//  rotation
//
//  Created by Yura on 4/23/23.
//

import SwiftUI

@available(iOS 14.0, *)
struct TestAlignment: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
            
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .padding()
        }
        
        .ignoresSafeArea()
        
    }
}

@available(iOS 14.0, *)
struct TestAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TestAlignment()
    }
}
