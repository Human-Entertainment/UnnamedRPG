import SwiftUI
import ImagineEngine

struct GameView: UIViewRepresentable {
    
    private let scene: GameViewController
    
    init(scene: ImagineEngine.Scene) {
        self.scene = GameViewController(scene: scene)
    }
    
    func makeUIView(context: Context) -> UIView {
        scene.game.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
