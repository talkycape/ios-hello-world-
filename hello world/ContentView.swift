//
//  ContentView.swift
//  hello world
//
//  Created by Ya-Chieh Lai on 6/27/21.
//

import SwiftUI
import AVFoundation
import AVKit
import WebKit

// steps to include this in our project
// 1. install cocoapods.  from the terminal: sudo gem install cocoapods
// 2. set up Pods for your project.  cd to parent directory of project and then: pod init
// 3. this will create a Podfile.  Modify it to add the line:   pod "youtube-ios-player-helper", "~> 1.0.3"
//    (for reference, see: /Users/sabrinahsieh/iCloud/Developer/hello\ world/Podfile)
// 4. type: pod install
// 5. close your project if it is open
// 6. re-open, BUT, open from top level (so Pods is included parallel to top level "hello world"

import youtube_ios_player_helper


// This splash view appears for 2.5 seconds when the app first starts
struct splashView: View {

    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                // go to main view
                ContentView()
            } else {
                Image("AwesomeSplash")
// An alternative Text version of the splash screen
//                Text("Awesome Splash Screen!")
//                    .font(Font.largeTitle)
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

// This is the main view
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NavigationLink(destination: myImageView()) {
                    Text("Follow a link to an image/video")
                }
                NavigationLink(destination: mySoundView()) {
                    Text("Follow a link to play a sound")
                }
                NavigationLink(destination: myVideoView()) {
                    Text("Follow a link to play a video")
                }
                NavigationLink(destination: myWebView()) {
                    Text("Follow a link to a webpage")
                }
                Divider()
                Button(action: {
                    playAudioAsset("gross")
                  }, label: {
                      Text("Or use a button - pull my finger!")
                  })
                Divider()
                HStack(spacing:10) {
                    Text("Horizontal Content:")
                    Image("spongebob")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    Image("plankton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    Image("patrick")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
            }
            .frame(width: 300, height: 800)
            .navigationTitle("Hello World")
        }
    }
}

// this is a secondary view with an image
struct myImageView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Here is an Image:")
            // Here is how you display an image and scale it to fix a certain window size
            Image("RedPanda")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            Text("And here is an embedded Youtube video:")
            myYTView()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 250)
        }
    }
}

// this is a secondary view that shows some text and plays a sound
struct mySoundView: View {
    var body: some View {
        VStack {
            Text("Show image or text here")
        }
        .onAppear(perform: {
            playAudioAsset("myTestSound")
        })
    }
}

// Not great practice to make this global, but easier to demonstrate
var audioPlayer: AVAudioPlayer!

// Here is a simple function to play a sound from Assets.xcassets
func playAudioAsset(_ assetName : String) {
   guard let audioData = NSDataAsset(name: assetName)?.data else {
      fatalError("Unable to find asset \(assetName)")
   }

   do {
      audioPlayer = try AVAudioPlayer(data: audioData)
      audioPlayer.play()
   } catch {
      fatalError(error.localizedDescription)
   }
}


// this is a secondary view with an video
struct myVideoView: View {
    var body: some View {
        VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "sandwich", withExtension: "mov")!))
    }
}

// to open a web page, we need to define a WebView
struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}

// this is a secondary view that opens a web page
struct myWebView: View {
    var body: some View {
//        WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
        WebView(request: URLRequest(url: URL(string: "https://youtu.be/8YjFbMbfXaQ")!))
    }
}

// Youtube wrapper
struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        //
    }
}

struct myYTView: View {
    
    var body: some View {
//        YTWrapper(videoID: "jQtP1dD6jQ0")
        YTWrapper(videoID: "8YjFbMbfXaQ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
