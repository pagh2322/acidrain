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
            make.leading.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 24)
            make.height.greaterThanOrEqualTo(36)
        }
        
        self.lifeLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.textField.snp.trailing)
            make.trailing.equalTo(self.snp.trailing)
            make.centerY.equalTo(self.textField)
        }
    }
}
