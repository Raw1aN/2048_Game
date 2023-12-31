//
//  Properties.swift
//  2048-Game
//
//  Created by Алексей Щукин on 10.05.2023.
//

import Foundation
import UIKit

class Properties{
    
    func tileColor(_ value: Int) -> UIColor {
      switch value {
      case 2:
        return UIColor(red: 238.0/255.0, green: 228.0/255.0, blue: 218.0/255.0, alpha: 1.0)
      case 4:
        return UIColor(red: 237.0/255.0, green: 224.0/255.0, blue: 200.0/255.0, alpha: 1.0)
      case 8:
        return UIColor(red: 242.0/255.0, green: 177.0/255.0, blue: 121.0/255.0, alpha: 1.0)
      case 16:
        return UIColor(red: 245.0/255.0, green: 149.0/255.0, blue: 99.0/255.0, alpha: 1.0)
      case 32:
        return UIColor(red: 246.0/255.0, green: 124.0/255.0, blue: 95.0/255.0, alpha: 1.0)
      case 64:
        return UIColor(red: 246.0/255.0, green: 94.0/255.0, blue: 59.0/255.0, alpha: 1.0)
      case 128, 256, 512, 1024, 2048:
        return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
      default:
        return UIColor.white
      }
    }
    
}
