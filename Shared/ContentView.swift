//
//  ContentView.swift
//  Shared
//
//  Created by Bastian Inuk Christensen on 15/10/2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject
    var scene: UnnamedScene
    
    var body: some View {
        GameView(scene: scene)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(ControllerPublisher())
        }
    }
}
