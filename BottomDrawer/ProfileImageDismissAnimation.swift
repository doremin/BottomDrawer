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
    
    let widthScaleFactor = origin.width / from.profileImageView.frame.width
    let heightScaleFactor = origin.height / from.profileImageView.frame.height
    let translateX = origin.midX - from.profileImageView.frame.midX
    let translateY = origin.midY - from.profileImageView.frame.midY
    
    // Translate * Rotate * Scale * x
    let modelMatrix = CGAffineTransform.identity
      .scaledBy(x: widthScaleFactor, y: heightScaleFactor)
      .translatedBy(x: translateX, y: translateY)

    
    UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
      from.profileImageView.transform = modelMatrix
      from.view.backgroundColor = UIColor.clear
    } completion: { _ in
      self.imageView.isHidden = false
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
}
