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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func recordPeriodButtonTapped(_ sender: Any) {
        recordPeriodButton.tintColor = .red
        let image = UIImage(named: "record")
        recordPeriodButton.setImage(image, for: .normal)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        print("clear button tapped")
    }
    
}

