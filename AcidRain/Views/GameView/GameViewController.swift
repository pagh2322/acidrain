//
//  GameViewController.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene?
    let gameView = GameView(frame: .zero)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.gameView.updateWithKeyboardHeight(keyboardHeight)
        }
    }
    @objc func keyboardWillHide(_ notification:NSNotification) {
        self.gameView.updateWithKeyboardHeight(0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
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
    
    @objc func showSettingView() {
        let alertController = UIAlertController(title: "Setting View", message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "home", style: .default) { _ in
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        
        guard let alertWindow = UIApplication.shared.windows.last,
              alertWindow.windowLevel == UIWindow.Level(rawValue: 10000001.0) else {
            return
        }
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension GameViewController {
    func setGameScene() {
        self.scene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: 240))
        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    func setGameView() {
        self.gameView.skView.presentScene(self.scene!)
    }
}

extension GameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for word in Word.wordList {
            if word.isEqualTo(textField.text ?? "") {
                word.removeFromParent()
                break
            }
        }
        textField.text = ""
        return true
    }
}
