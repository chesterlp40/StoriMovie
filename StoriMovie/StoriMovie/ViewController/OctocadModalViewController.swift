//
//  OctocadModalViewController.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 03/03/2024.
//

import SafariServices
import UIKit

/// Custom Modal to present an information UIView.
final class OctocadModalViewController: UIViewController {
    
    /// View configuration.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAllComponents()
    }
    
    /// Setup components.
    private func setupAllComponents() {
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
        
        let blurEffect = UIBlurEffect(
            style: .dark
        )
        let blurEffectView = UIVisualEffectView(
            effect: blurEffect
        )
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        self.view.addSubview(
            blurEffectView
        )
        
        let centralView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 300,
                height: 400
            )
        )
        centralView.center = self.view.center
        centralView.backgroundColor = Helper.Color.grain0
        centralView.layer.cornerRadius = 12
        self.view.addSubview(
            centralView
        )
        
        let imageView = UIImageView(
            frame: CGRect(
                x: ((centralView.frame.width / 2) - 50),
                y: 20,
                width: 100,
                height: 100
            )
        )
        imageView.image = UIImage(
            named: Helper.OctocadModalViewController.octocadKey
        )
        imageView.contentMode = .scaleToFill
        
        let titleLabel = UILabel(
            frame: CGRect(
                x: ((centralView.frame.width / 2) - 100),
                y: 125,
                width: 200,
                height: 50
            )
        )
        titleLabel.text = Helper.OctocadModalViewController.titleLabelText
        titleLabel.font = UIFont(
            name: Helper.OctocadModalViewController.titleFont,
            size: 17
        )
        titleLabel.textColor = Helper.Color.grain900
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        let subtitleLabel = UILabel(
            frame: CGRect(
                x: ((centralView.frame.width / 2) - 100),
                y: 180,
                width: 200,
                height: 90
            )
        )
        subtitleLabel.text = Helper.OctocadModalViewController.subTitleLabelText
        subtitleLabel.font = UIFont(
            name: Helper.OctocadModalViewController.subTitleFont,
            size: 13
        )
        subtitleLabel.textColor = Helper.Color.grain700
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        
        let primaryButton = UIButton(
            frame: CGRect(
                x: ((centralView.frame.width / 2) - 115),
                y: 290,
                width: 230,
                height: 40
            )
        )
        primaryButton.setTitle(
            Helper.OctocadModalViewController.primaryButtonTitle,
            for: .normal
        )
        primaryButton.titleLabel?.font = UIFont(
            name: Helper.OctocadModalViewController.buttonTitleFont,
            size: 14
        )
        primaryButton.backgroundColor = Helper.Color.grain900
        primaryButton.layer.cornerRadius = 20
        primaryButton.addTarget(
            self,
            action: #selector(openInAppBrowser),
            for: .touchUpInside
        )
        
        let secondaryButton = UIButton(
            frame: CGRect(
                x: ((centralView.frame.width / 2) - 115),
                y: 335,
                width: 230,
                height: 40
            )
        )
        secondaryButton.setTitle(
            Helper.OctocadModalViewController.secondaryButtonTitle,
            for: .normal
        )
        secondaryButton.titleLabel?.font = UIFont(
            name: Helper.OctocadModalViewController.buttonTitleFont,
            size: 14
        )
        secondaryButton.setTitleColor(
            Helper.Color.grain900,
            for: .normal
        )
        secondaryButton.backgroundColor = Helper.Color.grain0
        secondaryButton.layer.cornerRadius = 20
        secondaryButton.addTarget(
            self,
            action: #selector(dismissModal),
            for: .touchUpInside
        )
        
        centralView.addSubview(imageView)
        centralView.addSubview(titleLabel)
        centralView.addSubview(subtitleLabel)
        centralView.addSubview(primaryButton)
        centralView.addSubview(secondaryButton)
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissModal)
        )
        blurEffectView.addGestureRecognizer(
            tapGesture
        )
    }
    
    /// Open In App Browser instance for visit URL.
    @objc
    func openInAppBrowser() {
        if let url = URL(string: Helper.OctocadModalViewController.chesterlp40GithubUrl) {
            let safariViewController = SFSafariViewController(
                url: url
            )
            safariViewController.preferredControlTintColor = Helper.Color.grain800
            safariViewController.preferredBarTintColor = Helper.Color.grain300
            self.present(
                safariViewController,
                animated: true,
                completion: nil
            )
        }
    }
    
    /// Dismiss presented view..
    @objc
    func dismissModal() {
        self.dismiss(
            animated: true,
            completion: nil
        )
    }
}
