//
//  DatePickerView.swift
//  inTheClear
//
//  Created by Allison Mcentire on 6/2/22.
//

import Foundation
import UIKit

class DatePickerView: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var confirmButton: UIButton!
    
    private let calculationManager = CalculationManager()
    private let colorManager = ColorManager()
    private var dateToRecord = Date()
    
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
        confirmButton.setTitle("CONFIRM DATE", for: .normal)
        confirmButton.titleLabel?.textColor = .white
        confirmButton.backgroundColor = colorManager.defaultBlue
    }
    
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        dateToRecord = datePicker.date
    }
    
    
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        calculationManager.recordCurrentPeriodStartDate(date: dateToRecord)
        confirmButton.setTitle("DATE CONFIRMED", for: .normal)
        print(dateToRecord)
    }
}
