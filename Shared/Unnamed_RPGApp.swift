//
//  Unnamed_RPGApp.swift
//  Shared
//
//  Created by Bastian Inuk Christensen on 15/10/2020.
//

import SwiftUI

@main
struct Unnamed_RPGApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ControllerPublisher())
        }
    }
}
