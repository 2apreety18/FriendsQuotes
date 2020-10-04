//
//  BackgroundColor.swift
//  FriendsQuotes
//
//  Created by preety on 2/10/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit

struct BackgroundColorPalette {
    let colors = [ #colorLiteral(red: 0.737254902, green: 0.9019607843, blue: 1, alpha: 1),#colorLiteral(red: 0.6666666667, green: 0.7137254902, blue: 0.9843137255, alpha: 1),#colorLiteral(red: 0.9803921569, green: 0.6549019608, blue: 0.7215686275, alpha: 1),#colorLiteral(red: 0.8784313725, green: 0.9254901961, blue: 0.8705882353, alpha: 1),#colorLiteral(red: 0.9843137255, green: 0.9333333333, blue: 0.9019607843, alpha: 1)]
    
    func randomColor() -> UIColor {
        let randomNumber = Int.random(in: 0..<colors.count)
        return colors[randomNumber]
    }
}
