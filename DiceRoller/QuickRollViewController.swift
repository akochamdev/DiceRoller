//
//  QuickRollViewController.swift
//  DiceRoller
//
//  Created by Charles Diakoparaskevas on 6/19/16.
//  Copyright © 2016 Charles Diakoparaskevas. All rights reserved.
//

import UIKit

class QuickRollViewController: UIViewController {
  
  @IBOutlet var resultLabel: UILabel!
  @IBOutlet var rollsCollectionView: UICollectionView!
  @IBOutlet var dicePicker: UIPickerView!
  @IBOutlet var rollButton: UIButton!
  
  let pickerData = QuickRollData.data
  var individualRolls = [Int]()
  let rollButtonColor = UIColor.color(withRedValue: 76, greenValue: 217, blueValue: 100, alpha: 1.0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    rollsCollectionView.dataSource = self
    dicePicker.dataSource = self
    dicePicker.delegate = self
    
    resultLabel.text = ""
    
    rollButton.layer.borderWidth = 1
    rollButton.layer.borderColor = rollButtonColor.CGColor
    rollButton.layer.cornerRadius = 0.5 * rollButton.frame.size.width
    rollButton.backgroundColor = UIColor.whiteColor()
    rollButton.setTitleColor(rollButtonColor, forState: .Normal)
    rollButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
    rollButton.clipsToBounds = true
  }
  
  // MARK: - Control Actions
  @IBAction func rollTapped(sender: AnyObject) {
    // TODO - This is a temporary proof of concept implementation.  Replace with proper implementation
    // once the expression evaluator is made.
    let numberOfDice = pickerData[0][dicePicker.selectedRowInComponent(0)]
    //let diceConstant = pickerData[1][dicePicker.selectedRowInComponent(1)]
    let diceSides = pickerData[2][dicePicker.selectedRowInComponent(2)]
    let operatorValue = pickerData[3][dicePicker.selectedRowInComponent(3)]
    let modifierValue = pickerData[4][dicePicker.selectedRowInComponent(4)]

    //expressionLabel.text = "\(numberOfDice)\(diceConstant)\(diceSides)\(operatorValue)\(modifierValue)"
    
    individualRolls.removeAll()
    var result = 0
    let iterations = Int(numberOfDice)!
    for i in 0..<iterations {
      let dice = UInt32(Int(diceSides)!)
      // Add 1 since the result is 0 indexed.
      let roll = Int(arc4random_uniform(dice)) + 1
      individualRolls.append(roll)
      result += roll
      print("Roll \(i + 1): \(roll)   Total: \(result)")
    }
    
    let modifier = Int(modifierValue)!
    switch operatorValue {
    case "+":
      result += modifier
    case "-":
      result -= modifier
    default:
      result += 0
    }
    
    print("Total after applying modifier (\(operatorValue)\(modifierValue)): \(result)")
    resultLabel.text = "\(result)"
    
    rollButton.backgroundColor = UIColor.whiteColor()
    rollsCollectionView.reloadData()
  }
  
  @IBAction func rollTappedDown(sender: AnyObject) {
    rollButton.backgroundColor = rollButtonColor
  }
}

// MARK: - UICollectionViewDataSource
extension QuickRollViewController: UICollectionViewDataSource {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // If rolls array is empty, leave it at 0.  However, if not, then add 1 to take the modifier into consideration.
    return individualRolls.count == 0 ? individualRolls.count : individualRolls.count + 1
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("IndividualRoll", forIndexPath: indexPath) as! IndividualRollCell
    
    cell.layer.borderWidth = 1
    cell.layer.borderColor = rollButtonColor.CGColor
    cell.countView.backgroundColor = rollButtonColor
    cell.countLabel.textColor = UIColor.whiteColor()
    
    let isModifier = indexPath.row + 1 == individualRolls.count + 1
    cell.countLabel.text = isModifier ? "\(pickerData[3][dicePicker.selectedRowInComponent(3)])" : "\(indexPath.row + 1)"
    cell.valueLabel.text = isModifier ? "\(pickerData[4][dicePicker.selectedRowInComponent(4)])" : "\(individualRolls[indexPath.row])"
    
    return cell
  }
}

// MARK: - UIPickerViewDataSource
extension QuickRollViewController: UIPickerViewDataSource {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return pickerData.count
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData[component].count
  }
}

// MARK: - UIPickerViewDelegate
extension QuickRollViewController: UIPickerViewDelegate {
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[component][row]
  }
}

