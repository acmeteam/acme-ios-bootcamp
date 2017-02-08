//
//  FourthScreenViewController.swift
//  FirstProjectAssignment
//
//  Created by Aleksandar Ristanovic on 2/6/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class FourthScreenViewController: UIViewController {
    @IBOutlet weak var countLabel: UILabel!
    
    var firstName = "name"
    let numberString = " number of smiles: "
    var topString = ""
    var smileCount = 0
    
    let emotionalFaces = [
        FacialExpression(eyes: .closed, eyeBrows: .furrowed, mouth: .frown),
        FacialExpression(eyes: .open, eyeBrows: .normal, mouth: .smile),
        FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smirk),
        FacialExpression(eyes: .open, eyeBrows: .furrowed, mouth: .grin)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topString = firstName + numberString
        updateTopLabel()
    }

    private func updateTopLabel() {
        countLabel.text = topString + String(smileCount)
    }

    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        let face = FaceView(frame: CGRect(x: location.x - 50, y: location.y - 50, width: 100, height: 100))
        face.backgroundColor = UIColor.clear
        
        let facExprs = emotionalFaces[Int.random(upper_bound: emotionalFaces.count)]
        
        switch facExprs.eyeBrows {
        case .furrowed:
            face.eyeBrowTilt = -0.5
        case .normal:
            face.eyeBrowTilt = 0
        case .relaxed:
            face.eyeBrowTilt = 0.5
        }
        
        switch facExprs.eyes {
        case .closed:
            face.eyesOpen = false
        case .open:
            face.eyesOpen = true
        case .squinting:
            break
        }
        
        switch facExprs.mouth {
        case .frown:
            face.mouthCurvature = -1
        case .grin:
            face.mouthCurvature = -0.5
        case .neutral:
            face.mouthCurvature = 0
        case .smile:
            face.mouthCurvature = 1
        case .smirk:
            face.mouthCurvature = -0.5
        }
        
        view.addSubview(face)
        
        smileCount += 1
        updateTopLabel()
    }
    
}

//--------------------
extension Int {
    static func random(upper_bound: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upper_bound)))
    }
}
