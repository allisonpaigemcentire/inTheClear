//
//  ViewController.swift
//  inTheClear
//
//  Created by Allison Mcentire on 5/8/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var countDownDescriptionLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var recordPeriodButton: UIButton!
    
    private let calculationManager = CalculationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateState()
    }
    
    @IBAction func recordPeriodButtonTapped(_ sender: Any) {
        let shouldRecord = shouldStartRecording()
        guard shouldRecord else {
            stopRecordingCurrentPeriod()
            return
        }
        startRecordingCurrentPeriod()
        
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        calculationManager.clearUserDefaults()
        updateState()
    }
    
    
    private func startRecordingCurrentPeriod() {
        calculationManager.recordCurrentPeriodStartDate()
        displayRecordingButton()
        updateState()
    }
    
    private func stopRecordingCurrentPeriod() {
        calculationManager.recordCurrentPeriodEndDate()
        displayPlusButton()
        updateState()
    }
    
    private func shouldStartRecording() -> Bool {
        let currentPeriodStartDate = calculationManager.getCurrentPeriodStartDate()
        if currentPeriodStartDate == nil {
            return true
        }
        return false
    }
    
    private func shouldStopRecording() -> Bool {
        let currentPeriodStartDate = calculationManager.getCurrentPeriodStartDate()
        if currentPeriodStartDate != nil {
            return true
        }
        return false
    }
    
    private func displayPlusButton() {
        recordPeriodButton.tintColor = UIColor(named: "Bdazzled Blue")
        let image = UIImage(named: "plus")
        recordPeriodButton.setImage(image, for: .normal)
    }
    
    private func displayRecordingButton() {
        recordPeriodButton.tintColor = UIColor(named: "Red Salsa")
        let image = UIImage(named: "record")
        recordPeriodButton.setImage(image, for: .normal)
    }
    
    
    private func updateState() {
        // apply a gradient to the clearButton if any data is found in user defaults
        guard let blue = UIColor(named: "Bdazzled Blue")?.cgColor, let pink = UIColor(named: "Red Salsa")?.cgColor else { return }
        if calculationManager.checkForUserDefaultsData() {
            clearButton.applyGradient(colors: [blue, pink])
        } else {
            clearButton.removeGradient()
            clearButton.backgroundColor = UIColor(named: "Bdazzled Blue")
        }
        
        let numberOfDaysInCurrentPeriod = calculationManager.numberOfDaysInCurrentPeriod()
        guard numberOfDaysInCurrentPeriod == 0 else {
            // display state when user is recording a period
            countDownLabel.text = String(numberOfDaysInCurrentPeriod)
            countDownDescriptionLabel.text = "days in current period"
            displayRecordingButton()
            return
        }
        
        // display state when user is not recording a period
        countDownLabel.text = String(calculationManager.numberOfDaysUntilNextPeriod())
        countDownDescriptionLabel.text = "days until next period"
        displayPlusButton()
    }
    
    private func configureUI() {
        clearButton.layer.cornerRadius = 25.0
        clearButton.titleLabel?.text = "CLEAR"
    }
}

