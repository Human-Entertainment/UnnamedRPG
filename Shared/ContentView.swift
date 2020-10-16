//
//  ContentView.swift
//  Shared
//
//  Created by Bastian Inuk Christensen on 15/10/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gamePad = ControllerPublisher()
    @State var color = Color.primary
    
    let scene = UnnamedScene(size: Size(width: 375, height: 667))
    var body: some View {
        VStack {
            Text("Hello World \(color.description)")
                .padding()
            if gamePad.mainButtonPressed {
                Text("Button A pressed")
            }
            Test(color: $color)
            
        }.background(color)
        
    }
}

struct Test: View {
    @Binding var color: Color
    
    var body: some View {
        Text("\(color.description)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
            
    }
}
