//
//  ContentView.swift
//  Shared
//
//  Created by Abdullah Alhaider on 7/22/20.
//

import SwiftUI

#if !os(macOS)
struct VC: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: ViewController())
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
}
#endif

struct ContentView: View {
    var body: some View {
        #if os(macOS)
        return Text("You need to build a UI for macOS")
        #else
        return VC()
            .edgesIgnoringSafeArea(.bottom)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
