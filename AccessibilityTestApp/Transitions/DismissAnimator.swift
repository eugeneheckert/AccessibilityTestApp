//
//  DismissAnimator.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 2/28/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.viewController(forKey: .to),
            let source = transitionContext.viewController(forKey: .from) else {
                fatalError()
        }
        
        let sourceFrame = source.view.frame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: [], animations: {
            destination.view.frame = sourceFrame
            source.view.frame = source.view.frame.applying(CGAffineTransform(translationX: -(source.view.frame.size.width), y: 0))
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled && finished)
        }
    }
}
