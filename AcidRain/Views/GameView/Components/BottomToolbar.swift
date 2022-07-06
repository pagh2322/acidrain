//
//  BottomToolbar.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit
import SnapKit

class BottomToolbar: UIView {
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .default
        return textField
    }()
    
    let lifeLabel: UILabel = {
        let lifeLabel = UILabel()
        lifeLabel.text = "Life Label"
        lifeLabel.textAlignment = .center
        return lifeLabel
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
        [self.textField, self.lifeLabel].forEach { self.addSubview($0) }
    }
    
    func makeConstraints() {
        self.textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Consts.GameView.BottomToolbar.TextField.edgeInsets)
            make.width.equalTo(Consts.GameView.BottomToolbar.TextField.width)
            make.height.greaterThanOrEqualTo(Consts.GameView.BottomToolbar.TextField.height)
        }
        
        self.lifeLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.textField.snp.trailing)
            make.trailing.equalTo(self.snp.trailing)
            make.centerY.equalTo(self.textField)
        }
    }
}
