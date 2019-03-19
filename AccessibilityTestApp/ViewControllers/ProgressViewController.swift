//
//  ProgressViewController.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 3/15/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    let progressIncreaseAmount: Float = 0.1

    @IBOutlet var progressView: ProgressView!
    @IBOutlet var progressBarView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetProgress()
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        resetProgress()
    }
    
    func resetProgress() {
        progressBarView.progress = 0.0
        progressView.progressComplete = 0.0
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        progressBarView.progress += progressIncreaseAmount
        progressView.progressComplete += progressIncreaseAmount
    }
    
}
