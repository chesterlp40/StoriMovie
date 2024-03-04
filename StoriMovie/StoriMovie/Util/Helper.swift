//
//  Helper.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 02/03/2024.
//

import UIKit

/// Helper Class for expose all the resources.
enum Helper {
    
    // MARK: - Color Resources Section
    
    enum Color {
        static let grain0 = UIColor(named: "Grain0")
        static let grain100 = UIColor(named: "Grain100")
        static let grain200 = UIColor(named: "Grain200")
        static let grain300 = UIColor(named: "Grain300")
        static let grain400 = UIColor(named: "Grain400")
        static let grain500 = UIColor(named: "Grain500")
        static let grain600 = UIColor(named: "Grain600")
        static let grain700 = UIColor(named: "Grain700")
        static let grain800 = UIColor(named: "Grain800")
        static let grain900 = UIColor(named: "Grain900")
        
        static let rateGreen = UIColor(named: "RateGreen")
        static let rateYellow = UIColor(named: "RateYellow")
        static let rateRed = UIColor(named: "RateRed")
    }
    
    // MARK: - Generic Resources Section
    
    static let wifiExclamationResource = "wifi.exclamation"
    
    // MARK: - CircularProgressView Section
    
    enum CircularProgressView {
        static let strokeEndKeyPath = "strokeEnd"
        static let progressAnimationKey = "progressAnimation"
    }
    
    // MARK: - OctocadModalViewController Section
    
    enum OctocadModalViewController {
        static let octocadKey = "octocad"
        static let titleLabelText = "Enjoying the demo?\n Visit my GitHub"
        static let titleFont = "Rubik-SemiBold"
        static let subTitleLabelText = "There you'll find various repositories of test apps with differents themes."
        static let subTitleFont = "Rubik-Regular"
        static let primaryButtonTitle = "Visit Chesterlp40 account"
        static let secondaryButtonTitle = "Cancel"
        static let buttonTitleFont = "Rubik-Medium"
        static let chesterlp40GithubUrl = "https://github.com/chesterlp40"
    }
    
    // MARK: - MovieCell Section
    
    enum MovieCell {
        static let reuseIdentifier = "MovieCell"
        
        static func releasedDate(
            _ date: String
        ) -> String {
            return "Released:\n\(date)"
        }
    }
    
    // MARK: - MovieListViewController Section
    
    enum MovieListViewController {
        static let navigationTitleText = "Top Rated Movies"
        static let storyboardName = "Main"
        static let detailViewControllerIdentifier = "MovieDetailViewController"
    }
    
    // MARK: - MovieDetailViewController Section
    
    enum MovieDetailViewController {
        static let navigationTitleText = "Movie Detail View"
        static let rightButonResourceName = "person.fill"
        static let detailViewControllerIdentifier = "MovieDetailViewController"
        
        static func releasedDate(
            _ date: String
        ) -> String {
            return "Released: \(date)"
        }
        
        static func rated(
            _ rate: String
        ) -> String {
            return "Rated: \(rate)%"
        }
    }
    
    // MARK: - Navigation Section

    static func setNavigationConfig(
        _ navigation: UINavigationController?
    ) {
        navigation?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Helper.Color.grain700 ?? .gray,
            NSAttributedString.Key.font: UIFont(name: "Rubik-SemiBold", size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
        ]
        navigation?.navigationBar.isTranslucent = true
        navigation?.navigationBar.tintColor = Helper.Color.grain800
        navigation?.navigationBar.backgroundColor = Helper.Color.grain200
    }
}
