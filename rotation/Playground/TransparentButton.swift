//
//  TransparentButton.swift
//  rotation
//
//  Created by Yura on 5/1/23.
//

import SwiftUI

struct TransparentButton: View {
    @State var visible = true
    
    var body: some View {
        VStack {
            Button {
                print("Tapped...")
            } label: {
                Text("Press me")
            }
            .opacity(self.visible ? 1 : 0)

            Toggle(isOn: self.$visible) {
                Text("Show me")
            }
            .padding()
        }
    }
}

struct TransparentButton_Previews: PreviewProvider {
    static var previews: some View {
        TransparentButton()
    }
}
