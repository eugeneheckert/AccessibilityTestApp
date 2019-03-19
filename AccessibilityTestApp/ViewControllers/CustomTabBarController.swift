//
//  CustomTabBarController.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 2/28/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    //MARKL Variables
    private let sideMenuTransitioningDelegate = SideMenuTransitioningDelegate()
    private var interactor: InteractionController?

    //MARK: Lifecycle function
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let viewController = getSideMenuViewController() {
            let interactionController = InteractionController(viewController: self, delegate: sideMenuTransitioningDelegate)
            interactionController.viewControllerToPresent = viewController
            interactor = interactionController
        }
    }
    
    //MARK: IBActions
    @IBAction func MenuButtonTapped(_ sender: Any) {
        if let viewController = getSideMenuViewController() {
            present(viewController, animated: true, completion: nil)
        }
    }
    
    //MARK: Private function
    private func getSideMenuViewController() -> UIViewController?  {
        guard let sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") else {
            return nil
        }
        
        sideMenuViewController.modalPresentationStyle = .custom
        sideMenuViewController.transitioningDelegate = sideMenuTransitioningDelegate
        
        return sideMenuViewController
    }
    
}
