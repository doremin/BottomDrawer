//
//  ProfileDetailViewController.swift
//  BottomDrawer
//
//  Created by doremin on 2/29/24.
//

import UIKit

final class ProfileDetailViewController: BaseViewController {
  
  let profileImageView = ProfileImageView()
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    dismiss(animated: true)
  }
  
  override func addSubviews() {
    view.add {
      profileImageView
    }
    
    view.backgroundColor = .white
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
