//
//  ButtonAnimation.swift
//  FriendsQuotes
//
//  Created by preety on 4/10/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func startWiggling() {
        
        guard layer.animation(forKey: "wiggle") == nil else { return }
        guard layer.animation(forKey: "bounce") == nil else { return }
        
        let angle = 0.04

        let wiggle = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        wiggle.values = [-angle, angle]
        wiggle.autoreverses = true
        wiggle.duration = randomInterval(0.1, variance: 0.025)
        wiggle.repeatCount = Float.infinity
        layer.add(wiggle, forKey: "wiggle")

        let bounce = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounce.values = [4.0, 0.0]
        bounce.autoreverses = true
        bounce.duration = randomInterval(0.12, variance: 0.025)
        bounce.repeatCount = Float.infinity
        layer.add(bounce, forKey: "bounce")
    }

    func randomInterval(_ interval: TimeInterval, variance: Double) -> TimeInterval {
        return interval + variance * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
    }
}

extension UIView {
    enum AnimationKeyPath: String {
        case opacity = "opacity"
    }

    func flash(animation: AnimationKeyPath ,withDuration duration: TimeInterval = 0.5, repeatCount: Float = 5){
        let flash = CABasicAnimation(keyPath: animation.rawValue)
        flash.duration = duration
        flash.fromValue = 1 // alpha
        flash.toValue = 0 // alpha
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = repeatCount

        layer.add(flash, forKey: nil)
    }
}
