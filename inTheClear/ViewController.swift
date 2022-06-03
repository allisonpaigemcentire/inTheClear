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
    private let colorManager = ColorManager()
    
    private var isCurrentlyRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateState()
    }
    
    @IBAction func recordPeriodButtonTapped(_ sender: Any) {
        let shouldRecord = shouldStartRecording()
        guard shouldRecord else {
            stopRecordingCurrentPeriod()
            performSegue(withIdentifier: "showDatePicker", sender: nil)
            return
        }
        startRecordingCurrentPeriod()
        performSegue(withIdentifier: "showDatePicker", sender: nil)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        calculationManager.clearUserDefaults()
        updateState()
    }
    
    
    private func startRecordingCurrentPeriod() {
        displayRecordingButton()
        updateState()
    }
    
    private func stopRecordingCurrentPeriod() {
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
    
    
    func updateState() {
        // apply a gradient to the clearButton if any data is found in user defaults
        let colorManager = ColorManager()
        let numberOfPastCyclesInData = calculationManager.getArrayOfLengthOfEachCycle()?.count ?? 0
        if calculationManager.checkForUserDefaultsData() && numberOfPastCyclesInData != 0 {
            clearButton.removeGradient()
            clearButton.applyGradient(colors: colorManager.getArrayOfColors(number: numberOfPastCyclesInData))
        } else {
            clearButton.removeGradient()
            configureUI()
        }
        
        let numberOfDaysInCurrentPeriod = calculationManager.numberOfDaysInCurrentPeriod()
        guard numberOfDaysInCurrentPeriod == 0 else {
            // display state when user is recording a period
            isCurrentlyRecording = true
            countDownLabel.text = String(numberOfDaysInCurrentPeriod)
            countDownDescriptionLabel.text = "days in current cycle"
            clearButton.setTitle("CLEAR", for: .normal)
            displayRecordingButton()
            return
        }
        
        // display state when user is not recording a period
        countDownLabel.text = String(calculationManager.numberOfDaysUntilNextPeriod())
        countDownDescriptionLabel.text = "days until next cycle"
        displayPlusButton()
    }
    
    private func configureUI() {
        clearButton.layer.cornerRadius = clearButton.frame.height/2
        clearButton.setTitle("NO DATA TO CLEAR", for: .normal)
        clearButton.titleLabel?.textColor = .white
        clearButton.backgroundColor = colorManager.defaultBlue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDatePicker" else { return }
        let destination = segue.destination as! DatePickerView
        destination.isCurrentlyRecording = isCurrentlyRecording
        destination.callback = {
            self.updateState()
            self.isCurrentlyRecording = destination.isCurrentlyRecording
        }
    }
}
