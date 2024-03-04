//
//  ProfileImageDismissAnimation.swift
//  BottomDrawer
//
//  Created by doremin on 3/4/24.
//

import UIKit

final class ProfileImageDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
  
  let origin: CGRect
  let imageView: UIImageView
  
  init(origin: CGRect, imageView: UIImageView) {
    self.imageView = imageView
    self.origin = origin
    super.init()
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.25
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let from = transitionContext.viewController(forKey: .from) as? ProfileDetailViewController else {
      return
    }
    
    imageView.isHidden = true
    
    CATransaction.begin()
    CATransaction.setCompletionBlock {
      self.imageView.isHidden = false
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
    
    let positionAnimation = CABasicAnimation(keyPath: "position")
    positionAnimation.fromValue = [from.profileImageView.frame.midX, from.profileImageView.frame.midY]
    positionAnimation.toValue = [origin.midX, origin.midY]
    
    let sizeAnimation = CABasicAnimation(keyPath: "bounds")
    sizeAnimation.fromValue = CGRect(
      x: from.profileImageView.bounds.midX,
      y: from.profileImageView.bounds.midY,
      width: from.profileImageView.frame.width,
      height: from.profileImageView.frame.height)
    
    sizeAnimation.toValue = CGRect(
      x: from.profileImageView.bounds.midX,
      y: from.profileImageView.bounds.midY,
      width: origin.width,
      height: origin.height)
    
    let opacityAnimation = CABasicAnimation(keyPath: "backgroundColor")
    opacityAnimation.toValue = UIColor.clear.cgColor
    opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    
    let group = CAAnimationGroup()
    group.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    group.animations = [positionAnimation, sizeAnimation]
    
    from.profileImageView.layer.add(group, forKey: "animations")
    from.view.layer.add(opacityAnimation, forKey: "opacity")
    
    CATransaction.commit()
  }
}
