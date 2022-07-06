//
//  HomeViewController.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit
import GameKit

class HomeViewController: UIViewController {
    let homeView = HomeView(frame: UIScreen.main.bounds)
    
    var gvController: GameViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authenticateUser()
        GKLocalPlayer.local.register(self)
        
        self.addTargets()
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.homeView
    }
}

// MARK: - Button Target
extension HomeViewController {
    func addTargets() {
        self.homeView.singleModeButton.addTarget(self, action: #selector(playSingleMode), for: .touchUpInside)
        self.homeView.multiModeButton.addTarget(self, action: #selector(playMultiMode), for: .touchUpInside)
    }
    
    @objc func playSingleMode() {
        self.gvController = GameViewController()
        self.gvController?.modalTransitionStyle = .crossDissolve
        self.gvController?.modalPresentationStyle = .fullScreen
        self.present(self.gvController!, animated: true)
    }
    
    @objc func playMultiMode() {
        self.createMatch()
    }
}

// MARK: - Game Center
extension HomeViewController: GKGameCenterControllerDelegate {
    func authenticateUser() {
        // authenticateHandler will give a view controller we need to present it
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // Present the view controller so the player can sign in.
                self.present(viewController, animated: true)
                return
            }
            if error != nil {
                // Player could not be authenticated.
                // Disable Game Center in the game.
                return
            }
            
            // Player was successfully authenticated.
            // Check if there are any player restrictions before starting the game.
            
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit game content.
            }
            
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features.
            }
            
            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game communication UI.
            }
            
            // Perform any other configurations as needed (for example, access point).
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}


// MARK: - Multiplay
extension HomeViewController:
    GKLocalPlayerListener,
    GKMatchmakerViewControllerDelegate
{
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewController(
        _ viewController: GKMatchmakerViewController,
        didFailWithError error: Error
    ) { }
    
    func createMatch() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 10
        let vc = GKMatchmakerViewController(matchRequest: request)
        vc?.matchmakerDelegate = self
        vc?.matchmakingMode = .default
        self.present(vc!, animated: true)
    }
    
    func createRandomMatch() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 4
        GKMatchmaker.shared().findMatch(
            for: request,
            withCompletionHandler: { (match: GKMatch?, error: Error?) -> Void in
                if match != nil {
                    // Set the match delegate.
                    match?.delegate = self.gvController

                    // Start the game with the players in the match.
                    self.gvController = GameViewController()
                    self.gvController?.gkMatch = match
                    self.gvController?.modalTransitionStyle = .crossDissolve
                    self.gvController?.modalPresentationStyle = .fullScreen
                    self.present(self.gvController!, animated: true)
                }
                if error != nil {
                    // Handle the error that occurred finding a match.
                }
        })
    }
    
    func player(
        _ player: GKPlayer,
        didAccept invite: GKInvite
    ) {
        let vc = GKMatchmakerViewController(invite: invite)
        vc?.matchmakerDelegate = self
        let rvc = UIApplication.shared.windows.first!.rootViewController
        rvc?.present(vc!, animated: true)
    }
    
    // dismiss the view controller and start the game
    func matchmakerViewController(
        _ viewController: GKMatchmakerViewController,
        didFind match: GKMatch
    ) {
        viewController.dismiss(animated: true)
        self.gvController = GameViewController()
        match.delegate = self.gvController
        self.gvController?.gkMatch = match
        self.gvController?.modalTransitionStyle = .crossDissolve
        self.gvController?.modalPresentationStyle = .fullScreen
        self.present(self.gvController!, animated: true)
    }
}
