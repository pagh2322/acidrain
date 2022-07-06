//
//  HomeView.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit
import SnapKit

class HomeView: UIView {
    let logoLabel: UILabel = {
        let logoLabel = UILabel()
        logoLabel.text = "로고"
        logoLabel.textAlignment = .center
        return logoLabel
    }()
    
    let singleModeButton: UIButton = {
        let singleModeButton = UIButton()
        singleModeButton.setTitleColor(UIColor.brown, for: .normal)
        singleModeButton.setTitle("Single", for: .normal)
        return singleModeButton
    }()
    
    let multiModeButton: UIButton = {
        let multiModeButton = UIButton()
        multiModeButton.setTitleColor(UIColor.brown, for: .normal)
        multiModeButton.setTitle("Multi", for: .normal)
        return multiModeButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.makSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makSubviews() {
        [self.logoLabel, self.singleModeButton, self.multiModeButton].forEach { self.addSubview($0) }
    }
    
    func makeConstraints() {
        self.logoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        self.singleModeButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.logoLabel.snp.centerX)
            make.top.equalTo(self.logoLabel.snp.bottom).offset(50)
        }
        
        self.multiModeButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.singleModeButton.snp.centerX)
            make.top.equalTo(self.singleModeButton.snp.bottom).offset(20)
        }
    }
}
