import Combine
import Foundation
import GameController

enum DPadDirection {
    case none,up,down,left,right
}

class ControllerPublisher: ObservableObject {
    // MARK: The buttonpresses
    /// Wether or not the main button is pressed
    @Published var mainButtonPressed: Bool = false
    /// Wether or not the attack button is pressed
    @Published var secondaryButtonPressed: Bool = false
    /// The direction state of the dpad
    @Published var direction: DPadDirection = .none
    
    // MARK: The combine properties
    private var cancels = [AnyCancellable]()
    
    init(){
        cancels.append(
            NotificationCenter.default
                .publisher(for: NSNotification.Name.GCControllerDidBecomeCurrent)
                .sink(receiveValue: reactToController)
        )
        
    }
    
    // MARK: - Setup controller
    
    /// Small convenience function to set up the dpad
    private func dpadRegistration(dpad: GCControllerDirectionPad) {
        dpad.up.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
            if pressed {
                self.direction = .up
            } else {
                self.direction = .none
            }
        }
        
        dpad.left.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
            if pressed {
                self.direction = .left
            } else {
                self.direction = .none
            }
        }
        dpad.right.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
            if pressed {
                self.direction = .right
            } else {
                self.direction = .none
            }
        }
        
        dpad.down.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
            if pressed {
                self.direction = .down
            } else {
                self.direction = .none
            }
        }
    }
    
    /// Registers controller and binds constrols of controller to parent object.
    /// - Parameter notification: Any notification, but notice if anything but a GCController gets passed in nothing will happen.
    private func reactToController(_ notification: Notification) {
        guard let gameController = (notification.object as? GCController) else { return }
            
        print("\(gameController.vendorName ?? "unknown") is connected")
        gameController.extendedGamepad
            .map { gamePad in
                gamePad.buttonA.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
                    print("Pressed")
                    self.mainButtonPressed = pressed
                }
                gamePad.buttonB.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
                    self.secondaryButtonPressed = pressed
                }
                
                dpadRegistration(dpad: gamePad.dpad)
        }
        
        gameController.microGamepad
            .map { gamePad in
                gamePad.buttonA.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
                    print("Pressed")
                    self.mainButtonPressed = pressed
                }
                gamePad.buttonX.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
                    self.secondaryButtonPressed = pressed
                }
                dpadRegistration(dpad:  gamePad.dpad )
                
            }
    }
}
