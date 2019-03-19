//
//  PresentationAnimator.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 2/28/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class PresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.viewController(forKey: .to),
            let source = transitionContext.viewController(forKey: .from) else {
                fatalError()
        }
        let containerView = transitionContext.containerView
        containerView.insertSubview(destination.view, belowSubview: source.view)
        
        let sourceFrame = source.view.frame
        var initialFrame = transitionContext.initialFrame(for: destination)
        initialFrame = initialFrame == .zero ? containerView.bounds : initialFrame
        
        destination.view.frame = initialFrame.applying(CGAffineTransform(translationX: -(containerView.frame.size.width), y: 0))
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: [], animations: {
            destination.view.frame = transitionContext.finalFrame(for: destination)
            source.view.frame = sourceFrame.applying(CGAffineTransform(translationX: source.view.bounds.size.width * 0.75, y: 0))
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled && finished)
        }
    }

}
