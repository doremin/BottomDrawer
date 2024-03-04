//
//  ProfileDetailViewController.swift
//  BottomDrawer
//
//  Created by doremin on 2/29/24.
//

import UIKit

final class ProfileDetailViewController: BaseViewController {
  
  let profileImageView = ProfileImageView()
  
  var interactionController: UIPercentDrivenInteractiveTransition?
  
  override func addSubviews() {
    view.add {
      profileImageView
    }
    
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(didTapView))
    view.backgroundColor = .white
    view.addGestureRecognizer(gesture)
    view.isUserInteractionEnabled = true
    profileImageView.isUserInteractionEnabled = false
  }
  
  @objc func didTapView(_ sender: UIPanGestureRecognizer) {
    let progress = sender.translation(in: view).y / view.bounds.height

    switch sender.state {
    case .began:
      dismiss(animated: true)
    case .changed:
      interactionController?.update(progress)
    case .cancelled, .ended:
      interactionController?.finish()
      if progress > 0.5 {
        interactionController?.finish()
      } else {
        interactionController?.cancel()
      }
    default:
      break
    }
  }
  
  override func setupConstraints() {
    NSLayoutConstraint.activate([
      profileImageView.topAnchor.constraint(equalTo: view.topAnchor),
      profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
      profileImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
      profileImageView.heightAnchor.constraint(equalToConstant: 300)
    ])
  }
}

#Preview {
  return ProfileDetailViewController()
}
