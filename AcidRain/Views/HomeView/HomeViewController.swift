//
//  HomeViewController.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView(frame: UIScreen.main.bounds)
    
    var gvController: GameViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTargets()
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.homeView
    }
}

extension HomeViewController {
    func addTargets() {
        self.homeView.singleModeButton.addTarget(self, action: #selector(playSingleMode), for: .touchUpInside)
    }
    
    @objc func playSingleMode() {
        self.gvController = GameViewController()
        self.gvController?.modalTransitionStyle = .crossDissolve
        self.gvController?.modalPresentationStyle = .fullScreen
        self.present(self.gvController!, animated: true)
    }
}
