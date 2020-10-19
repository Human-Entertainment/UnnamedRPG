import Combine
import Foundation
import GameController
import os

enum DPadDirection: CustomStringConvertible {
    case none,up,down,left,right

    var description: String {
        switch self {
            case .none:  return "none"
            case .up:    return "up"
            case .down:  return "down"
            case .left:  return "left"
            case .right: return "right"
        }
    }
}

class ControllerPublisher: ObservableObject {
    // MARK: The buttonpresses
    /// Wether or not the main button is pressed
    @Published
    var mainButtonPressed: Bool = false
    /// Wether or not the attack button is pressed
    @Published
    var secondaryButtonPressed: Bool = false
    /// The direction state of the dpad
    @Published
    var direction: DPadDirection = .none
    
    // MARK: The combine properties
    private var cancels = [AnyCancellable]()
    
    // MARK: Logger
    private var logger = Logger(subsystem: "app.inuk.controller", category: "Controller")
    
    init() {
        cancels.append(
            NotificationCenter.default
                .publisher(for: NSNotification.Name.GCControllerDidBecomeCurrent)
                .sink(receiveValue: reactToController)
        )
        
    }
    
    // MARK: - Setup controller
    
    private func reactToController(_ notification: Notification) {
        (notification.object as? GCController).map(registerGamePad)
    }
    
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
    private func registerGamePad(_ gameController: GCController) {
        logger.info("\(gameController.vendorName ?? "unknown") is connected")
        gameController.extendedGamepad
            .map { gamePad in
                gamePad.buttonA.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
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
                    self.mainButtonPressed = pressed
                }
                gamePad.buttonX.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) in
                    self.secondaryButtonPressed = pressed
                }
                dpadRegistration(dpad:  gamePad.dpad )
                
            }
    }
}
