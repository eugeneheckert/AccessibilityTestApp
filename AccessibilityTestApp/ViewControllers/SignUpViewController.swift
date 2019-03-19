//
//  SignUpViewController.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 3/5/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: Variables
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var emailStackView: FormEntryStackView!
    @IBOutlet var firstNameStackView: FormEntryStackView!
    @IBOutlet var lastNameStackView: FormEntryStackView!
    @IBOutlet var usernameStackView: FormEntryStackView!
    @IBOutlet var passwordStackView: FormEntryStackView!
    @IBOutlet var signUpButton: UIButton!
    
    //MARK: Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideErrorMessages()
        closeButton.titleLabel?.adjustsFontForContentSizeCategory = true
        signUpButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    //MARK: IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        _ = validateForm()
    }
    
    //MARK: private functions
    private func hideErrorMessages() {
        emailStackView.errorLabel.isHidden = true
        firstNameStackView.errorLabel.isHidden = true
        lastNameStackView.errorLabel.isHidden = true
        usernameStackView.errorLabel.isHidden = true
        passwordStackView.errorLabel.isHidden = true
    }
    
    private func validateForm() -> Bool {
        
        var isValid = true
        
        if emailStackView.textField.text?.isEmpty ?? true {
            emailStackView.errorLabel.isHidden = false
            isValid = false
        } else {
            emailStackView.errorLabel.isHidden = true
        }
        
        if firstNameStackView.textField.text?.isEmpty ?? true {
            firstNameStackView.errorLabel.isHidden = false
            isValid = false
        } else {
            firstNameStackView.errorLabel.isHidden = true
        }
        
        if lastNameStackView.textField.text?.isEmpty ?? true {
            lastNameStackView.errorLabel.isHidden = false
            isValid = false
        } else {
            lastNameStackView.errorLabel.isHidden = true
        }
        
        if usernameStackView.textField.text?.isEmpty ?? true {
            usernameStackView.errorLabel.isHidden = false
            isValid = false
        } else {
            usernameStackView.errorLabel.isHidden = true
        }
        
        if passwordStackView.textField.text?.isEmpty ?? true {
            passwordStackView.errorLabel.isHidden = false
            isValid = false
        } else {
            passwordStackView.errorLabel.isHidden = true
        }
        
        return isValid
    }
    
}
