//
//  CountDownTimerViewController.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 3/4/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class CountDownTimerViewController: UIViewController {

    //MARK: Variables
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var selectTimeButton: UIButton!
    @IBOutlet var saveTimeButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var countDownDatePicker: UIDatePicker!
    @IBOutlet var datePickerBottomConstraint: NSLayoutConstraint!
    
    private let saveDateKey = "SavedDateKey"
    private var timer = Timer()
    private var countDownTime = 0.0
    private var countDownDate: Date?
    
    //MARK: Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundView.alpha = 0
        saveTimeButton.isHidden = true
        
        countDownDate = getSavedDate()
        
        updateLayout()
    }
    
    //MARK: IBActions
    @IBAction func selectTimeTapped(_ sender: Any) {
        showDatePicker()
    }
    
    @IBAction func saveTimeTapped(_ sender: Any) {
        if let date = countDownDate {
            saveDate(date: date)
        }
    }
    
    @IBAction func cancelTimePickerTapped(_ sender: Any) {
        hideDatePicker()
    }
    
    @IBAction func timePickerDoneTapped(_ sender: Any) {
        saveTimeButton.isHidden = false
        countDownDate = Date().addingTimeInterval(countDownDatePicker.countDownDuration)
        updateLayout()
        hideDatePicker()
        runTimer()
    }
    
    //MARK: Private Functions
    private func runTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        countDownTime -= 1
        if countDownTime <= 0 {
            countDownTime = 0.0
            timer.invalidate()
        }
        updateCountDownLabel()
    }
    
    private func updateLayout() {
        
        if let date = countDownDate {
            titleLabel.text = "Time remaining:"
            timerLabel.isHidden = false
            countDownTime = date.timeIntervalSinceNow
            updateCountDownLabel()
            runTimer()
        } else {
            titleLabel.text = "How long would you like the timer?"
            timerLabel.isHidden = true
        }
    }
    
    private func updateCountDownLabel() {
        let timeBreakDown = remainingTimeBreakDown(seconds: Int(countDownTime))
        timerLabel.text = "\(timeBreakDown.hours)hr, \(timeBreakDown.minutes)m, \(timeBreakDown.second)s"
    }
    
    private func showDatePicker() {
        datePickerBottomConstraint.constant = 0
        
        self.backgroundView.isHidden = false
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
            self.backgroundView.alpha = 1.0
        }) { finished in
            if finished {
            }
        }
    }
    
    private func hideDatePicker() {
        datePickerBottomConstraint.constant = 300
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
            self.backgroundView.alpha = 0
        }) { finished in
            if finished {
                self.backgroundView.isHidden = true
            }
        }
    }
    
    private func getSavedDate() -> Date? {
        guard let date = UserDefaults.standard.value(forKey: saveDateKey) as? Date else { return nil }
        
        if checkIfDateIsValid(date) {
            return date
        }
        
        return nil
    }
    
    private func saveDate(date: Date) {
        UserDefaults.standard.setValue(date, forKey: saveDateKey)
    }
    
    private func checkIfDateIsValid(_ date: Date) -> Bool {
        if date > Date() {
            return true
        }
        
        return false
    }
    
    private func remainingTimeBreakDown( seconds: Int) -> (hours: Int, minutes: Int, second: Int) {
        return (seconds / 3600,(seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}
