//
//  WelcomeViewController.swift
//  NSLayoutConstraintAPI
//
//  Created by Petar Cvijic on 1/30/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Let's add a simple logo image view to view
        let logo = UIImageView(image: UIImage(named: "logo"))
        //logo.accessibilityIdentifier = "LogoImageView"
        
        // Don't forget to put this line
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        // Add logo view to view hierarchy
        view.addSubview(logo)
        
        // In short, we want logo image view to be centered 
        // both in vertical and horizontal directions with no image distortion
        
        // The said above is easy to do in storyboard, but in code, it will need
        // some additional effort
        
       
        let centerX = NSLayoutConstraint(item: logo,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)

        let centerY = NSLayoutConstraint(item: logo,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        
        let leading = NSLayoutConstraint(item: logo,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .leadingMargin,
                                         multiplier: 1,
                                         constant: 0)

        let trailing = NSLayoutConstraint(item: logo,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .trailingMargin,
                                         multiplier: 1,
                                         constant: 0)

          // Constraint that will breake autolayout
//        let width = NSLayoutConstraint(item: logo,
//                                          attribute: .width,
//                                          relatedBy: .equal,
//                                          toItem: view,
//                                          attribute: .width,
//                                          multiplier: 0.5,
//                                          constant: 0)
        
        view.addConstraints([centerX, centerY, leading, trailing])
//      view.addConstraint(width)

        let imageSize = logo.image!.size
        let aspectRatio = NSLayoutConstraint(item: logo,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: logo,
                                            attribute: .height,
                                            multiplier: imageSize.width / imageSize.height,
                                            constant: 1)
        
        logo.addConstraint(aspectRatio)
    }
}

