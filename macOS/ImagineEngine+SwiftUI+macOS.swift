import SwiftUI
import ImagineEngine
import os

struct GameView: NSViewRepresentable {
    let logger = Logger(subsystem: "app.inuk.gameview", category: "View")
    
    private let scene: GameViewController
    @EnvironmentObject
    private var gamePad: ControllerPublisher
    
    init(scene: ImagineEngine.Scene) {
        self.scene = GameViewController(size: scene.size, scene: scene)
    }
    
    func makeNSView(context: Context) -> NSView {
        scene.game.view
    }
    
    func updateNSView(_: NSView, context: Context) {
        logger.debug("Player moved \(gamePad.direction, align: .right(columns: 1), privacy: .public)")
    }
}
