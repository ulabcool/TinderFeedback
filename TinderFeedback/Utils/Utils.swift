//
//  Utils.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import Foundation
import UIKit

/*
 
Colour Red:
R: 239
G: 120
B: 96

Colour Blue:
R: 164
G: 202
B: 217

Colour Yellow:
R: 253
G: 212
B: 97
*/

class Utils {
    class func colorForRating(rating: Int) -> UIColor {
        var color: UIColor!
        switch rating {
        case 1,2:
            color = UIColor(red: 239 / 255.0, green: 120 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        case 3:
            color = UIColor(red: 164 / 255.0, green: 202 / 255.0, blue: 217 / 255.0, alpha: 1.0)
        default:
            color = UIColor(red: 253 / 255.0, green: 212 / 255.0, blue: 97 / 255.0, alpha: 1.0)
        }

        return color
    }
}
