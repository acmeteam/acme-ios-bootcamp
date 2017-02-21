//
//  UIBigRoundedButton.swift
//  Clock
//
//  Created by Petar Cvijic on 1/26/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

// MARK: - Big Button with Rounded Corners
class UIBigRoundedButton: UIButton {
    // MARK: Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 10
    }
}
