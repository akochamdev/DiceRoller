//
//  QuickRollViewController.swift
//  DiceRoller
//
//  Created by Ako Diakoparaskevas on 6/19/16.
//  Copyright © 2016 Charles Diakoparaskevas. All rights reserved.
//

import UIKit

class QuickRollViewController: UIViewController {
  
  @IBOutlet var expressionLabel: UILabel!
  @IBOutlet var resultLabel: UILabel!
  @IBOutlet var dicePicker: UIPickerView!
  @IBOutlet var rollButton: UIButton!
  
  let pickerData = QuickRollData.data
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dicePicker.dataSource = self
    dicePicker.delegate = self
    
    expressionLabel.text = ""
    resultLabel.text = ""
    rollButton.setBackgroundColor(red: 92, green: 184, blue: 92, alpha: 1.0)
  }
  
  // MARK - Control Actions
  @IBAction func rollTapped(sender: AnyObject) {
    // TODO - This is a temporary proof of concept implementation.  Replace with proper implementation
    // once the expression evaluator is made.
    let numberOfDice = pickerData[0][dicePicker.selectedRowInComponent(0)]
    let diceConstant = pickerData[1][dicePicker.selectedRowInComponent(1)]
    let diceSides = pickerData[2][dicePicker.selectedRowInComponent(2)]
    let operatorValue = pickerData[3][dicePicker.selectedRowInComponent(3)]
    let modifierValue = pickerData[4][dicePicker.selectedRowInComponent(4)]

    expressionLabel.text = "\(numberOfDice)\(diceConstant)\(diceSides)\(operatorValue)\(modifierValue)"
    
    var result = 0
    let iterations = Int(numberOfDice)!
    for i in 0..<iterations {
      let dice = UInt32(Int(diceSides)!)
      // Add 1 since the result is 0 indexed.
      let roll = Int(arc4random_uniform(dice)) + 1
      result += roll
      print("Roll \(i + 1): \(roll)   Total: \(result)")
    }
    
    let modifier = Int(modifierValue)!
    switch operatorValue {
    case "+":
      result += modifier
    case "-":
      result -= modifier
    case "*":
      result *= modifier
    case "/":
      result /= modifier
    default:
      result += 0
    }
    
    print("Total after applying modifier (\(operatorValue)\(modifierValue)): \(result)")
    resultLabel.text = "\(result)"
  }
}

// MARK - UIPickerViewDataSource
extension QuickRollViewController: UIPickerViewDataSource {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return pickerData.count
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData[component].count
  }
}

// MARK - UIPickerViewDelegate
extension QuickRollViewController: UIPickerViewDelegate {
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[component][row]
  }
}

