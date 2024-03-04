//
//  CircularProgressView.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 03/03/2024.
//

import UIKit

/// Custom Class for  ProgressView Component.
final class CircularProgressView: UIView {
    
    private let progressLayer = CAShapeLayer()
    
    /// Initialize **CircularProgressView**.
    ///
    /// - Parameter frame: **CGRect**.
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        self.setupCircularPath()
    }
    
    /// Initialize **CircularProgressView**.
    ///
    /// - Parameter aDecoder: **NSCoder**.
    required init?(
        coder aDecoder: NSCoder
    ) {
        super.init(
            coder: aDecoder
        )
        self.setupCircularPath()
    }
    
    /// Setup configuration.
    private func setupCircularPath() {
        let circularPath = UIBezierPath(
            ovalIn: self.bounds
        )
        
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 6
        backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(
            backgroundLayer
        )
        
        self.progressLayer.path = circularPath.cgPath
        self.progressLayer.strokeColor = UIColor.red.cgColor
        self.progressLayer.lineWidth = 6
        self.progressLayer.fillColor = UIColor.clear.cgColor
        self.progressLayer.strokeEnd = 0
        self.layer.addSublayer(
            self.progressLayer
        )
    }
    
    /// Animate the progress.
    ///
    /// - Parameters:
    ///   - value: Value to finish.
    ///   - duration: Time of the proccess,
    func animateProgress(
        to value: Double,
        duration: TimeInterval = 1.0
    ) {
        let animation = CABasicAnimation(
            keyPath: Helper.CircularProgressView.strokeEndKeyPath
        )
        animation.toValue = value
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(
            name: .easeInEaseOut
        )
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        self.progressLayer.add(
            animation,
            forKey: Helper.CircularProgressView.progressAnimationKey
        )
        self.updateColor(
            for: value
        )
    }
    
    /// Update **CircularProgressView** background color throgh the progress.
    ///
    /// - Parameter progress: Progress state.
    private func updateColor(
        for progress: Double
    ) {
        if progress >= 0.75 {
            self.progressLayer.strokeColor = UIColor.rateGreen.cgColor
        } else if progress >= 0.5 {
            self.progressLayer.strokeColor = UIColor.rateYellow.cgColor
        } else {
            self.progressLayer.strokeColor = UIColor.rateRed.cgColor
        }
    }
}
