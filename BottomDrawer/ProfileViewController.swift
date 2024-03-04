//
//  ProfileViewController.swift
//  BottomDrawer
//
//  Created by doremin on 2/28/24.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
  func profileViewControllerTapped()
  func profileViewControllerDragged(_ sender: UIPanGestureRecognizer)
}

final class ProfileViewController: BaseViewController {
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Profile"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isUserInteractionEnabled = true
    return label
  }()
  
  let profileImageView: ProfileImageView = {
    let imageView = ProfileImageView()
    imageView.image = UIImage(named: "cat")
    return imageView
  }()
  
  lazy var presentAnimation = ProfileImagePresentAnimation(
    origin: view.convert(profileImageView.frame, to: nil),
    imageView: profileImageView)
  
  lazy var dismissAnimation = ProfileImageDismissAnimation(
    origin: view.convert(profileImageView.frame, to: nil),
    imageView: profileImageView
  )
  
  weak var delegate: ProfileViewControllerDelegate?
  
  let interacttionController = UIPercentDrivenInteractiveTransition()
  
  var isOpened = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setUpGesture()
    
    profileImageView.onTapped = { [weak self] in
      let detailViewController = ProfileDetailViewController()
      detailViewController.modalPresentationStyle = .custom
      detailViewController.transitioningDelegate = self
      detailViewController.interactionController = self?.interacttionController
      self?.present(detailViewController, animated: true)
    }
  }
  
  private func setUpGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelDidTapped))
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(titleLabelDidDragged))
    titleLabel.addGestureRecognizer(tapGesture)
    titleLabel.addGestureRecognizer(panGesture)
  }
  
  @objc func titleLabelDidDragged(_ sender: UIPanGestureRecognizer) {
    delegate?.profileViewControllerDragged(sender)
  }
  
  @objc func titleLabelDidTapped() {
    delegate?.profileViewControllerTapped()
  }
  
  override func addSubviews() {
    view.add {
      titleLabel
      profileImageView
    }
  }
  
  override func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      titleLabel.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    NSLayoutConstraint.activate([
      profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      profileImageView.heightAnchor.constraint(equalToConstant: 110),
      profileImageView.widthAnchor.constraint(equalToConstant: 110)
    ])
  }
}

extension ProfileViewController: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return presentAnimation
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return dismissAnimation
  }
  
  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    interacttionController
  }
}

#Preview {
  return ProfileViewController()
}
