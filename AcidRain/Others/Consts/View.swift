//
//  View.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import UIKit

extension Consts {
    struct GameView {
        struct TopToolbar {
            static let height: CGFloat = 40
            struct ScoreLabel {
                static let edgeInsets = UIEdgeInsets(
                    top: 20,
                    left: 20,
                    bottom: 0,
                    right: 0
                )
            }
            struct SettingButton {
                static let width: CGFloat = 28
                static let height: CGFloat = 28
                
                static let edgeInsets = UIEdgeInsets(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 20
                )
            }
        }
        struct SKView {
            static let heightWithNoKeyboard: CGFloat = UIScreen.main.bounds.height - TopToolbar.height - 2 * BottomToolbar.offset - BottomToolbar.height - Consts.statusHeight
            static var heightWithKeyboard: CGFloat = heightWithNoKeyboard {
                didSet {
                    GameScene.size.height = heightWithKeyboard
                }
            }
        }
        struct BottomToolbar {
            static let height: CGFloat = 40
            static let offset: CGFloat = 4
            struct TextField {
                static let width: CGFloat = UIScreen.main.bounds.width / 2 - 24
                static let height: CGFloat = 36
                
                static let edgeInsets = UIEdgeInsets(
                    top: 0,
                    left: 12,
                    bottom: 0,
                    right: 12
                )
            }
        }
    }
}
