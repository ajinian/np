//
//  NotificationBanner.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/8/20.
//

import Foundation
import UIKit

class NotificationBanner {
    
    static let labelLeftMarging = CGFloat(16)
    static let labelTopMargin = CGFloat(24)
    static let animateDuration = 0.2
    static let bannerAppearanceDuration: TimeInterval = 3
    static var isDisplayed:Bool = false
  
    static func show(_ text: String) {
        if !isDisplayed {
            let superView = UIApplication.shared.windows.first!.rootViewController!.view!
            let height = CGFloat(64)
            let width = superView.bounds.size.width

            let bannerView = UIView(frame: CGRect(x: 0, y: superView.bounds.height, width: width, height: height))
            bannerView.layer.opacity = 1
            bannerView.backgroundColor = UIColor(displayP3Red: 1, green: 0.31, blue: 0.27, alpha: 1.0)
            bannerView.translatesAutoresizingMaskIntoConstraints = false

            let label = UILabel(frame: CGRect.zero)
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.text = text
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center

            bannerView.addSubview(label)
            superView.addSubview(bannerView)

            let labelCenterYContstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: bannerView, attribute: .centerY, multiplier: 1, constant: 0)
            let labelCenterXConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: bannerView, attribute: .centerX, multiplier: 1, constant: 0)
            let labelWidthConstraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width - labelLeftMarging*2)
            let labelTopConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: bannerView, attribute: .top, multiplier: 1, constant: labelTopMargin)

            let bannerWidthConstraint = NSLayoutConstraint(item: bannerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
            let bannerCenterXConstraint = NSLayoutConstraint(item: bannerView, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: 0)
            let bannerTopConstraint = NSLayoutConstraint(item: bannerView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: 0-height)

            NSLayoutConstraint.activate([labelCenterYContstraint, labelCenterXConstraint, labelWidthConstraint, labelTopConstraint, bannerWidthConstraint, bannerCenterXConstraint, bannerTopConstraint])

            UIView.animate(withDuration: animateDuration) {
                bannerTopConstraint.constant = superView.bounds.height - 64
                superView.layoutIfNeeded()
            }
            isDisplayed = true

            UIView.animate(withDuration: animateDuration, delay: bannerAppearanceDuration, options: [], animations: {
                bannerTopConstraint.constant = superView.bounds.height
                superView.layoutIfNeeded()
            }, completion: { finished in
                if finished {
                    bannerView.removeFromSuperview()
                    isDisplayed = false
                }
            })
        }
    }
}
