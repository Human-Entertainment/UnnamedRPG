import ImagineEngine
import protocol SwiftUI.ObservableObject
import Combine
@_exported import struct ImagineEngine.Size
import os

class UnnamedScene: Scene, ObservableObject  {
    private let controller: ControllerPublisher
    private let player = Player()
    
    // MARK: The combine properties
    private var cancels = [AnyCancellable]()
    
    private var logger = Logger(subsystem: "app.inuk.gameview", category: "View")
    
    override func setup()
    {
        backgroundColor = Color(red: 0, green: 0, blue: 0.3, alpha: 1)
    }
    
    init(gamePad: ControllerPublisher, size: Size)
    {
        self.controller = gamePad
        super.init(size: size)
        
        // TODO: This is where player movement happens
        self.controller
            .$direction
            .sink { [weak self] direction in
                self?.logger
                     .debug("Player moved \(direction, align: .right(columns: 1), privacy: .public)")

                self?.player
                     .startMovingPlayer(direction: direction)
            }.store(in: &cancels)
        
        self.controller
            .$mainButtonPressed
            .sink { [weak self] isPressed in
                self?.logger
                    .debug("Player \(isPressed ? "" : "didn't ")press main button")
            }.store(in: &cancels)
        
        self.controller
            .$secondaryButtonPressed
            .sink { [weak self] isPressed in
                self?.logger
                    .debug("Player \(isPressed ? "" : "didn't ")press secondary button")
            }.store(in: &cancels)
    }
}
