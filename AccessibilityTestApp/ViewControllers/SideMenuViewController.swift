//
//  SideMenuViewController.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 2/26/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    //MARK: Variables
    let optionList = ["Create an Account", "Message Center"]
    private var interactor: InteractionController?

    //MARK: Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let transitioner = transitioningDelegate as? SideMenuTransitioningDelegate {
            let interactionController = InteractionController(viewController: self, delegate: transitioner)
            interactor = interactionController
        }
    }
    
    //MARK: IBActions
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: TableViewDelegate
extension SideMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") else { return }
            present(signUpVC, animated: true, completion: nil)
        }
    }
    
}

//MARK: TableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = optionList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell") as? MenuItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = title
        
        if title == "Message Center" {
            cell.countLabel.text = "99"
        } else {
            cell.countLabel.isHidden = true
        }
        
        return cell
    }
    
    
}
