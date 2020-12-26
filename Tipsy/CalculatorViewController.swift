//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    @IBOutlet weak var peopleStepper: UIStepper!
    
    var pctAmount = 0.0
    var peopleSplit = 1
    var totalAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitNumberLabel.text = "\(peopleSplit)"
        peopleStepper.minimumValue = 1
        // Do any additional setup after loading the view.
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        print ("onTipChanged pressed tag => \(sender.tag)")
        
        billTextField.resignFirstResponder()
        
        sender.isSelected = true
        
        if (sender.tag == 0) {
            print("zero button")
            pctAmount = 0.0
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        } else if (sender.tag == 1) {
            print("ten button")
            pctAmount = 0.1
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
        } else if (sender.tag == 2) {
            print("twenty button")
            pctAmount = 0.2
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
        }
        
        print ("Tip amount is: \(pctAmount)")
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        peopleSplit = Int(sender.value)
        splitNumberLabel.text = peopleSplit.description
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        let amountValue = Double(billTextField.text ??  "0.0")
        print("Number of people to split: \(peopleSplit)")
        print("Amount value: \(amountValue ?? 0.0)")
        
        let tipValue = amountValue! * pctAmount
        totalAmount = (amountValue! + tipValue) / Double(peopleSplit)
        
        print("Total amount is: \(totalAmount)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Preparing for segue...")
        if segue.destination is ResultsViewController {
            let controller = segue.destination as? ResultsViewController
            controller?.resultAmount = totalAmount
            controller?.totalPeople = peopleSplit
            controller?.pct = pctAmount
        }
    }
    
    
    
}

