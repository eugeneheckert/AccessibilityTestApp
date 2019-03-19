//
//  PercentView.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 2/19/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    //MARK: Variables
    var lineThickness: Float = 10.0
    
    var progressComplete: Float = 0.0 {
        didSet {
            animatePercentUpdate()
        }
    }
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    
    var progressColor = UIColor.black {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.lightGray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    //MARK: Overriden Functions
    override func didMoveToSuperview() {
        drawCirclularPath()
    }
    
    //MARK: Private Functions
    fileprivate func drawCirclularPath() {
        self.layer.cornerRadius = self.frame.width / 2
        let path = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.height / 2), radius: (frame.width - 2) / 2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        
        trackLayer.path = path.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = CGFloat(lineThickness)
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        progressLayer.path = path.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = CGFloat(lineThickness)
        progressLayer.strokeEnd = CGFloat(progressComplete)
        layer.addSublayer(progressLayer)
    }
    
    fileprivate func animatePercentUpdate() {
        let animation = CABasicAnimation(keyPath: "pathanimation")
        
        animation.duration = 0.25
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = progressComplete
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(progressComplete)
        progressLayer.add(animation, forKey: "animation")
    }
    
    //MARK: Public Functions
    func resetPercent() {
        progressComplete = 0.0
        
    }

}
