//
//  ButtonExtensions.swift
//  DiceRoller
//
//  Created by Charles Diakoparaskevas on 6/21/16.
//  Copyright © 2016 Charles Diakoparaskevas. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
  func setBackgroundColor(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    self.backgroundColor = UIColor.color(withRedValue: red, greenValue: green, blueValue: blue, alpha: alpha)
  }
}