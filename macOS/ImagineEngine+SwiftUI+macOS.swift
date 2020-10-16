import SwiftUI
import ImagineEngine

struct GameView: NSViewRepresentable {
    
    private let scene: GameViewController
    
    init(scene: ImagineEngine.Scene) {
        self.scene = GameViewController(size: scene.size, scene: scene)
    }
    
    func makeNSView(context: Context) -> NSView {
        scene.game.view
    }
    
    func updateNSView(_: NSView, context: Context) {
        
    }
}
