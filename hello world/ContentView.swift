//
//  ContentView.swift
//  hello world
//
//  Created by Sabrina Hsieh on 6/27/21.
//

import SwiftUI

struct splashView: View {

    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView()
            } else {
                Text("Awesome Splash Screen!")
                    .font(Font.largeTitle)
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}
struct ContentView: View {
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
