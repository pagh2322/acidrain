//
//  TopToolbar.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit
import SnapKit

class TopToolbar: UIView {
    let settingButton: UIButton = {
        let settingButton = UIButton()
        settingButton.setBackgroundImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingButton.tintColor = .black
        return settingButton
    }()
    let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.text = "score"
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = .brown
        return scoreLabel
    }()
    let tempPersonIcon: UILabel = {
        let tempPersonIcon = UILabel()
        tempPersonIcon.text = "people's icon"
        tempPersonIcon.textAlignment = .center
        tempPersonIcon.textColor = .black
        return tempPersonIcon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeSubviews() {
        [self.scoreLabel, self.settingButton, self.tempPersonIcon].forEach { self.addSubview($0) }
    }
    
    func makeConstraints() {
        self.scoreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.snp.leading).inset(Consts.GameView.TopToolbar.ScoreLabel.edgeInsets)
        }
        self.settingButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.snp.trailing).inset(Consts.GameView.TopToolbar.SettingButton.edgeInsets)
            make.width.height.greaterThanOrEqualTo(Consts.GameView.TopToolbar.SettingButton.width)
        }
        self.tempPersonIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.scoreLabel)
            make.trailing.equalTo(self.settingButton)
        }
    }
}
