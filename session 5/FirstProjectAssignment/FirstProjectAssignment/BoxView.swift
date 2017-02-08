//
//  BoxView.swift
//  FirstProjectAssignment
//
//  Created by Aleksandar Ristanovic on 2/6/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class BoxView: UIView {

    var colors = [UIColor.black, UIColor.blue, UIColor.cyan, UIColor.yellow, UIColor.red, UIColor.orange, UIColor.green]
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(rect: CGRect(x: bounds.minX, y: bounds.minY, width: 100, height: 100))
        let color = colors[Int.random(upper_bound: colors.count)]
    
        color.setFill()
        path.fill()
    }

}
