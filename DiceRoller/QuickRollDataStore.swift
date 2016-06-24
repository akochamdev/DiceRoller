//
//  QuickRollDataStore.swift
//  DiceRoller
//
//  Created by Charles Diakoparaskevas on 6/20/16.
//  Copyright © 2016 Charles Diakoparaskevas. All rights reserved.
//

import Foundation

struct QuickRollData {
  static let numberOfDice = Array(1...20).map { String($0) }
  static let diceConstant = ["d"]
  static let diceSides = ["2", "3", "4", "6", "8", "10", "12", "20", "30", "100"]
  static let operators = ["+", "-", "*", "/"]
  static let modifierValues = Array(0...100).map { String($0) }
  static var data: [[String]] {
    return [numberOfDice, diceConstant, diceSides, operators, modifierValues]
  }
}

