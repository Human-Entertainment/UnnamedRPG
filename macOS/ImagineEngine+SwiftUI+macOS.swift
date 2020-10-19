import SwiftUI
import ImagineEngine
import os

struct GameView: NSViewRepresentable {
    // MARK: Debuggin stuff
    let logger = Logger(subsystem: "app.inuk.gameview", category: "View")
    
    // MARK: Game logic stuff
    private let viewController: GameViewController
    
    init(scene: ImagineEngine.Scene) {
        self.viewController = GameViewController(size: scene.size, scene: scene)
    }
    
    func makeNSView(context: Context) -> NSView {
        viewController.game.view
    }
    
    func updateNSView(_: NSView, context: Context) {
    }
}
