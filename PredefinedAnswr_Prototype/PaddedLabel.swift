//
//  PaddedLabel.swift
//  PredefinedAnswr_Prototype
//
//  Created by Daniel Robertson on 11/11/2015.
//  Copyright © 2015 Daniel Robertson. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets(top: -55, left: 10, bottom: 0, right: 0)
        
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}
