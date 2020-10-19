import ImagineEngine
import protocol SwiftUI.ObservableObject
import Combine
@_exported import struct ImagineEngine.Size
import os

class UnnamedScene: Scene, ObservableObject  {
    private let controller: ControllerPublisher
    
    // MARK: The combine properties
    private var cancels = [AnyCancellable]()
    
    private var logger = Logger(subsystem: "app.inuk.gameview", category: "View")
    
    override func setup() {
        backgroundColor = Color(red: 0, green: 0, blue: 0.3, alpha: 1)
    }
    
    init(gamePad: ControllerPublisher, size: Size) {
        self.controller = gamePad
        super.init(size: size)
        
        // TODO: This is where player movement happens
        cancels.append (
            self.controller
                .$direction
                .sink { [weak self] direction in
                    self?.logger
                         .debug("Player moved \(gamePad.direction, align: .right(columns: 1), privacy: .public)")
                }
        )
    }
}
