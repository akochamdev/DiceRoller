//
//  UIColorExtensions.swift
//  DiceRoller
//
//  Created by Charles Diakoparaskevas on 6/21/16.
//  Copyright © 2016 Charles Diakoparaskevas. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  static func color(withRedValue redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
  }
}
