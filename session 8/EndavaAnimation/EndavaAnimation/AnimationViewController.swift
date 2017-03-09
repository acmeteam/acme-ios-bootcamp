//
//  ViewController.swift
//  EndavaAnimation
//
//  Created by Bratislav Ljubisic on 3/1/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let showImageAnimation = #selector(AnimationViewController.showImageAnimation)
    static let showFadeOutAction = #selector(AnimationViewController.showFadeOutAction)
    static let showFadeInAction = #selector(AnimationViewController.showFadeInAction)
    static let moveOutAction = #selector(AnimationViewController.moveOutAction)
    static let moveInAction = #selector(AnimationViewController.moveInAction)
    static let transformAction = #selector(AnimationViewController.transformAction)
    static let prepareStageAction = #selector(AnimationViewController.prepareStageAction)
}

class AnimationViewController: UIViewController {

    @IBOutlet weak var friendlyTiger: UIImageView!
    
    @IBOutlet weak var animateAction: UIButton!
    
    private var nextAction: Selector!
    private var currentAction: Selector!
    let friendlyBear = UIImageView(image: UIImage(named: "bear"))
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var firstContact = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.friendlyTiger.alpha = 0.0
        currentAction = .showImageAnimation
        nextAction = .showFadeOutAction
        self.animateAction.addTarget(self, action: currentAction, for: .touchUpInside)
        
    }

    func showImageAnimation() {
        UIView.animate(withDuration: 0.5) { 
            self.friendlyTiger.alpha = 1.0
        }
        self.animateAction.removeTarget(self, action: .showImageAnimation, for: .touchUpInside)
        self.animateAction.addTarget(self, action: .showFadeOutAction, for: .touchUpInside)
    }
    
    func showFadeOutAction() {
        UIView.animate(withDuration: 0.5) { 
            self.friendlyTiger.alpha = 0.0
        }
        self.animateAction.removeTarget(self, action: .showFadeOutAction, for: .touchUpInside)
        self.animateAction.addTarget(self, action: .showFadeInAction, for: .touchUpInside)
    }
    
    func showFadeInAction() {
        UIView.animate(withDuration: 0.5) {
            self.friendlyTiger.alpha = 1.0
        }
        self.animateAction.removeTarget(self, action: .showFadeInAction, for: .touchUpInside)
        self.animateAction.addTarget(self, action: .moveOutAction, for: .touchUpInside)
    }
    
    func moveOutAction() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseIn, .curveEaseOut], animations: {
            self.friendlyTiger.center.x -= self.view.bounds.width
        })
        self.animateAction.setTitle("Move In Image", for: .normal)
        self.animateAction.removeTarget(self, action: .moveOutAction, for: .touchUpInside)
        self.animateAction.addTarget(self, action: .moveInAction, for: .touchUpInside)
    }
    
    func moveInAction() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseIn, .curveEaseOut], animations: {
            self.friendlyTiger.center.x += self.view.bounds.width
        })
        self.animateAction.setTitle("Change Image", for: .normal)
        self.animateAction.removeTarget(self, action: .moveInAction, for: .touchUpInside)
        self.animateAction.addTarget(self, action: .transformAction, for: .touchUpInside)
    }
    
    func transformAction() {
        
        
        self.friendlyBear.center = self.friendlyTiger.center
        
        UIView.transition(with: self.view, duration: 0.5, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
            self.friendlyTiger.removeFromSuperview()
            self.view.addSubview(self.friendlyBear)
        })
        self.animateAction.removeTarget(self, action: .transformAction, for: .touchUpInside)
        self.animateAction.addTarget(self, action: .prepareStageAction, for: .touchUpInside)
    }
    
    func prepareStageAction() {
        UIView.animate(withDuration: 0.5) {
            self.animateAction.isEnabled = false
            self.animateAction.isHidden = true
            var imageFrame = self.friendlyBear.frame
            imageFrame.size.width = 120
            imageFrame.size.height = 120
            self.friendlyBear.frame = imageFrame
            self.friendlyBear.center.y -= 100
        }
        
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        view.addSubview(barrier)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [self.friendlyBear])
        //gravity.setAngle(1.1434, magnitude: 1)
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [self.friendlyBear])
        collision.collisionDelegate = self
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [self.friendlyBear, barrier])
        itemBehaviour.elasticity = 0.7
        animator.addBehavior(itemBehaviour)
    }
}

extension AnimationViewController: UICollisionBehaviorDelegate {
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("Boundary contact occurred - \(identifier)")
        let collidingView = item as! UIView
        collidingView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        UIView.animate(withDuration: 0.3) {
            collidingView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
}

