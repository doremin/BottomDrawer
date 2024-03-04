//
//  ProfileDetailViewController.swift
//  BottomDrawer
//
//  Created by doremin on 2/29/24.
//

import UIKit

final class ProfileDetailViewController: BaseViewController {
  
  let profileImageView = ProfileImageView()
  
  override func addSubviews() {
    view.add {
      profileImageView
    }
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
    view.backgroundColor = .white
    view.addGestureRecognizer(gesture)
    view.isUserInteractionEnabled = true
  }
  
  @objc func didTapView(_ sender: UITapGestureRecognizer) {
    self.dismiss(animated: true)
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
