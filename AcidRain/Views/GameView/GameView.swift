//
//  GameView.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit
import SpriteKit
import SnapKit

class GameView: UIView {
    let topToolbar = TopToolbar(frame: .zero)
    let skView = SKView(frame: .zero)
    let bottomToolbar = BottomToolbar(frame: .zero)
    var skViewHeightConstraint: Constraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.makeSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeSubviews() {
        [self.topToolbar, self.skView, self.bottomToolbar].forEach { self.addSubview($0) }
    }
    
    func makeConstraints() {
        self.topToolbar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(40)
        }
        
        self.skView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.topToolbar.snp.bottom)
            self.skViewHeightConstraint = make.height.greaterThanOrEqualTo(UIScreen.main.bounds.height - 40 - 8 - 40 - Consts.statusHeight).constraint
        }
        
        self.bottomToolbar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
            make.top.equalTo(self.skView.snp.bottom).offset(4)
            make.height.greaterThanOrEqualTo(40)
        }
    }
    
    func updateWithKeyboardHeight(_ height: CGFloat) {
        self.skViewHeightConstraint.deactivate()
        self.skView.snp.makeConstraints { make in
            self.skViewHeightConstraint = make.height.greaterThanOrEqualTo(UIScreen.main.bounds.height - height - 40 - 8 - 40 - Consts.statusHeight).constraint
        }
    }
}
