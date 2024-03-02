//
//  Helper.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 02/03/2024.
//

import UIKit

final class Helper {
    static func setNavigationConfig(
        _ navigation: UINavigationController?
    ) {
        navigation?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.grainDark,
            NSAttributedString.Key.font: UIFont(name: "Rubik-SemiBold", size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
        ]
        navigation?.navigationBar.isTranslucent = true
        navigation?.navigationBar.tintColor = UIColor.grainDark
        navigation?.navigationBar.backgroundColor = UIColor.whiteGrained
    }
}
