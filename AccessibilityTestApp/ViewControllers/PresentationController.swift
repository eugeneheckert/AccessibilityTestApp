//
//  PresentationController.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 3/1/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: presentedView?.bounds ?? .zero)
        view.backgroundColor = .clear
        view.alpha = 0
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        containerView?.addSubview(backgroundView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.backgroundView.alpha = 0.4
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.backgroundView.alpha = 0
        }, completion: { context in
            self.backgroundView.removeFromSuperview()
        })
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        return containerView.frame
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

}
