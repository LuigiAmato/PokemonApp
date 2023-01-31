//
//  Extension.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import Foundation
import UIKit


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


public enum ActionTag {
    case actionDone
    case actionModal
    case actionPush
    case actionOther
    case actionPlus
}
