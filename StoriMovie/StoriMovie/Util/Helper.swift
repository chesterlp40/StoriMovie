//
//  Helper.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 02/03/2024.
//

import UIKit

/// Helper Class for expose all the resources.
enum Helper {
    
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
        static let titleLabelText = "Enjoying the test?\n Visit my GitHub"
        static let titleFont = "Rubik-SemiBold"
        static let subTitleLabelText = "In my personal GitHub you can find a lot of test app to show you my developer skills."
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
        static let rightButonResourceName = "rectangle.portrait.and.arrow.forward.fill"
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
            NSAttributedString.Key.foregroundColor: UIColor.grain700,
            NSAttributedString.Key.font: UIFont(name: "Rubik-SemiBold", size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
        ]
        navigation?.navigationBar.isTranslucent = true
        navigation?.navigationBar.tintColor = UIColor.grain800
        navigation?.navigationBar.backgroundColor = UIColor.grain200
    }
}
