//
//  GameViewController.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit
import SpriteKit
import GameKit

class GameViewController: UIViewController {
    var scene: GameScene?
    let gameView = GameView(frame: .zero)
    
    var gkMatch: GKMatch?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initNotificationObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.deinitNotificationObservers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameView.bottomToolbar.textField.delegate = self
        self.setGameScene()
        self.setGameView()
        self.gameView.bottomToolbar.textField.becomeFirstResponder()
        self.gameView.topToolbar.settingButton.addTarget(self, action: #selector(showSettingView), for: .touchUpInside)
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.gameView
    }
    
    @objc func showSettingView() {
        self.endGame()
//        let alertController = UIAlertController(title: "Setting View", message: "", preferredStyle: .alert)
//        let confirmAction = UIAlertAction(title: "home", style: .default) { _ in
//            self.dismiss(animated: true)
//        }
//        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
//        alertController.addAction(confirmAction)
//        alertController.addAction(cancelAction)
//
//
//        guard let alertWindow = UIApplication.shared.windows.last,
//              alertWindow.windowLevel == UIWindow.Level(rawValue: 10000001.0) else {
//            return
//        }
//        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    func endGame() {
        self.scene?.isStart = false
        self.dismiss(animated: true)
    }
}

// MARK: - Keyboard Notification
extension GameViewController {
    func initNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deinitNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if Consts.GameView.SKView.heightWithKeyboard == Consts.GameView.SKView.heightWithNoKeyboard {
                Consts.GameView.SKView.heightWithKeyboard -= keyboardHeight
            }
            self.gameView.updateWithKeyboardHeight(keyboardHeight)
            self.scene?.size = Consts.GameScene.size
        }
    }
    @objc func keyboardWillHide(_ notification:NSNotification) {
        if Consts.GameView.SKView.heightWithKeyboard != Consts.GameView.SKView.heightWithNoKeyboard {
            Consts.GameView.SKView.heightWithKeyboard = Consts.GameView.SKView.heightWithNoKeyboard
        }
        self.gameView.updateWithKeyboardHeight(0)
        self.scene?.size = Consts.GameScene.size
    }
}

extension GameViewController {
    func setGameScene() {
        self.scene = GameScene(size: Consts.GameScene.size)
        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    func setGameView() {
        self.gameView.skView.ignoresSiblingOrder = true
        self.gameView.skView.presentScene(self.scene!)
        self.gameView.skView.showsPhysics = true
    }
}

extension GameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for word in WordBlock.wordList {
            if word.isEqualTo(textField.text ?? "") {
                word.removeFromParent()
                break
            }
        }
        textField.text = ""
        return true
    }
}

// MARK: - Multiplay
extension GameViewController: GKMatchDelegate {
    func match(
        _ match: GKMatch,
        player: GKPlayer,
        didChange state: GKPlayerConnectionState
    ) {
        print("Available player slots: \(String(match.expectedPlayerCount))")
        
        switch state {
        case .connected:
            print("connected")
        case .disconnected:
            print("disconnected")
        default:
            print("default")
        }
    }
    
    func match(
        _ match: GKMatch,
        shouldReinviteDisconnectedPlayer player: GKPlayer
    ) -> Bool {
        false
    }
    
    func sendMessage(content: String) {
        do {
            let data: Data? = content.data(using: .utf8)
            try self.gkMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            return
        }
    }
    
    func match(
        _ match: GKMatch,
        didReceive data: Data,
        fromRemotePlayer player: GKPlayer
    ) {
        let content = String(decoding: data, as: UTF8.self)
        print(content)
    }
}

// MARK: - Over Riding
extension GameViewController {
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
