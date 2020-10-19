import ImagineEngine

class Player {
    private(set) var actor = Actor()
    private var token: ActionToken? = nil
    
    public
    func startMovingPlayer(direction: DPadDirection)
    {
        switch direction {
            case .down:
                self.token = self.actor.perform( MoveAction(destination: Point(), duration: .infinity) )
            case .up:
                self.token = self.actor.perform( MoveAction(destination: Point(), duration: .infinity) )
            case .left:
                self.token = self.actor.perform( MoveAction(destination: Point(), duration: .infinity) )
            case .right:
                self.token = self.actor.perform( MoveAction(destination: Point(), duration: .infinity) )
            case .none:
                self.token?.cancel()
        }
    }
}
