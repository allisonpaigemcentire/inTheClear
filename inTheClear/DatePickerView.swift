//
//  DatePickerView.swift
//  inTheClear
//
//  Created by Allison Mcentire on 6/2/22.
//

import Foundation
import UIKit

class DatePickerView: UIViewController {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var confirmEndDateButton: UIButton!
    
    private let calculationManager = CalculationManager()
    private let colorManager = ColorManager()
    private var startDateToRecord: Date?
    private var endDateToRecord = Date()
    
    var isCurrentlyRecording = false
    var callback : (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidDisappear(_ animated : Bool) {
        super.viewDidDisappear(animated)
        callback?()
    }
   
    private func configureUI() {
        confirmButton.layer.cornerRadius = confirmButton.frame.height/2
        confirmButton.setTitle("CONFIRM START DATE", for: .normal)
        confirmButton.titleLabel?.textColor = .white
        confirmButton.backgroundColor = colorManager.defaultBlue
        confirmButton.isHidden = isCurrentlyRecording
        confirmEndDateButton.layer.cornerRadius = confirmButton.frame.height/2
        confirmEndDateButton.setTitle("CONFIRM END DATE", for: .normal)
        confirmEndDateButton.titleLabel?.textColor = .white
        confirmEndDateButton.backgroundColor = colorManager.defaultBlue
        confirmEndDateButton.isHidden = !isCurrentlyRecording
        if isCurrentlyRecording {
            startDateToRecord = calculationManager.getCurrentPeriodStartDate()
            guard let currentStartDate = calculationManager.getCurrentPeriodStartDate() else { return }
            let readableDate = calculationManager.getFormattedDate(date: currentStartDate)
            descriptionLabel.text = "Current start date: \(readableDate)"
        }
    }
    
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        guard startDateToRecord == nil else {
            endDateToRecord = datePicker.date
            return
        }
        startDateToRecord = datePicker.date
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        confirmButton.setTitle("START DATE CONFIRMED", for: .normal)
        confirmEndDateButton.isHidden = false
        descriptionLabel.text = "Has your current cycle ended yet? If not, dismiss this view."
        guard let date = startDateToRecord else {
            calculationManager.recordCurrentPeriodStartDate(date: Date())
            return
        }
        calculationManager.recordCurrentPeriodStartDate(date: date)
        
    }
    
    @IBAction func confirmEndButtonTapped(_ sender: Any) {
        calculationManager.recordCurrentPeriodEndDate(date: endDateToRecord)
        confirmEndDateButton.setTitle("END DATE CONFIRMED", for: .normal)
        descriptionLabel.text = "CYCLE RECORDED"
        isCurrentlyRecording = false
    }
}
