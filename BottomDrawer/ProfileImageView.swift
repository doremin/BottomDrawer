//
//  ProfileImageView.swift
//  BottomDrawer
//
//  Created by doremin on 2/29/24.
//

import UIKit

final class ProfileImageView: UIImageView {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    UIView.animate(withDuration: 0.1) {
      self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    UIView.animate(withDuration: 0.1) {
      self.transform = .identity
    }
  }
  
  var onTapped: (() -> Void)?
  
  init() {
    super.init(frame: .zero)
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
    gesture.cancelsTouchesInView = false
    addGestureRecognizer(gesture)
    translatesAutoresizingMaskIntoConstraints = false
    contentMode = .scaleAspectFill
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func viewDidTapped() {
    onTapped?()
  }
}
