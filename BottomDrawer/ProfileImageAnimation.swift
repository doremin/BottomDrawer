//
//  ProfileImageAnimation.swift
//  BottomDrawer
//
//  Created by doremin on 2/29/24.
//

import UIKit

final class ProfileImageAnimation: NSObject, UIViewControllerAnimatedTransitioning {
  
  let origin: CGRect
  let imageView: UIImageView
  
  init(origin: CGRect, imageView: UIImageView) {
    self.imageView = imageView
    self.origin = origin
    super.init()
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let to = transitionContext.viewController(forKey: .to) as? ProfileDetailViewController
    else {
      return
    }
    
    to.profileImageView.image = imageView.image
    
    let containerView = transitionContext.containerView
    containerView.addSubview(to.view)
    
    let positionAnimation = CABasicAnimation(keyPath: "position")
    positionAnimation.fromValue = [origin.midX, origin.midY]
    positionAnimation.toValue = [to.view.frame.midX, 150]
    
    let sizeAnimation = CABasicAnimation(keyPath: "bounds")
    sizeAnimation.fromValue = CGRect(
      x: origin.midX,
      y: origin.midY,
      width: origin.width,
      height: origin.height)
    
    sizeAnimation.toValue = CGRect(
      x: to.view.frame.midX,
      y: to.view.frame.midY,
      width: to.view.frame.width,
      height: 300)
    
    let group = CAAnimationGroup()
    group.duration = 1
    group.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    group.animations = [positionAnimation, sizeAnimation]
    
    to.profileImageView.layer.add(group, forKey: "animations")
    
    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
  }
  
  
}
