//
//  InteractionController.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 3/1/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class InteractionController: UIPercentDrivenInteractiveTransition {
    
    private let viewController: UIViewController
    private var edgeGesture: UIPanGestureRecognizer?
    weak var transitionDelegate: SideMenuTransitioningDelegate?
    var viewControllerToPresent: UIViewController?
    
    init(viewController: UIViewController, delegate: SideMenuTransitioningDelegate?) {
        self.viewController = viewController
        self.transitionDelegate = delegate
        super.init()
        
        edgeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        edgeGesture.map(viewController.view.addGestureRecognizer)
    }
    
    @objc private func handlePan(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            transitionDelegate?.percentTransition = self
            if panGesture.translation(in: panGesture.view).x < 0 {
                viewController.dismiss(animated: true, completion: nil)
            } else if let vc = viewControllerToPresent {
                viewController.present(vc, animated: true, completion: nil)
            }
        case .changed:
            let translation = panGesture.translation(in: panGesture.view)
            let progress = abs(translation.x / viewController.view.frame.width)
            update(progress)
        default:
            if percentComplete > 0.4 {
                finish()
            } else {
                cancel()
            }
            
            transitionDelegate?.percentTransition = nil
        }
    }
}
