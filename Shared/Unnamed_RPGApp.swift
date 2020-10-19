//
//  Unnamed_RPGApp.swift
//  Shared
//
//  Created by Bastian Inuk Christensen on 15/10/2020.
//

import SwiftUI

@main
struct Unnamed_RPGApp: App {
    let controller = ControllerPublisher()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(controller)
                .environmentObject(UnnamedScene(gamePad: controller, size: Size(width: 375, height: 667)))
        }
    }
}
