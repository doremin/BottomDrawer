//
//  MainViewController.swift
//  BottomDrawer
//
//  Created by doremin on 2/28/24.
//

import UIKit

final class MainViewController: BaseViewController {
  
  private enum Constants {
    static let topMargin: CGFloat = 100
  }
  
  let profileViewController = ProfileViewController()
  let settingsViewController = SettingsViewController()
  
  override init() {
    super.init()
    
    self.setUpChildren([
      profileViewController,
      settingsViewController
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    view.backgroundColor = .darkGray
    
    profileViewController.delegate = self
    settingsViewController.delegate = self
    
    round(profileViewController.view)
    round(settingsViewController.view)
  }
      
  private func round(_ view: UIView) {
    let path = UIBezierPath(
      roundedRect: view.bounds,
      byRoundingCorners: [.topRight, .topLeft],
      cornerRadii: CGSize(width: 40, height: 40))
    
    let layer = CAShapeLayer()
    layer.path = path.cgPath
    view.layer.mask = layer
  }
  
  private func setUpChildren(_ children: [UIViewController]) {
    children
      .enumerated()
      .forEach {
        addChild($0.element)
        view.addSubview($0.element.view)
        $0.element.view.tag = $0.offset
        $0.element.didMove(toParent: self)
        $0.element.view.frame = CGRect(
          x: view.bounds.minX,
          y: view.bounds.maxY - Constants.topMargin * CGFloat(children.count - $0.offset),
          width: view.bounds.width,
          height: view.bounds.height - Constants.topMargin * CGFloat(children.count) + Constants.topMargin)
      }
  }
  
  func openProfile() {
    let width = profileViewController.view.bounds.width
    let height = profileViewController.view.bounds.height
    
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 0,
      options: .curveEaseInOut)
    {
      self.profileViewController.view.frame = CGRect(
        x: self.view.bounds.minX,
        y: Constants.topMargin,
        width: width,
        height: height)
    } completion: { _ in
      self.profileViewController.isOpened = true
    }
  }
  
  func openSettings() {
    let width = settingsViewController.view.bounds.width
    let height = settingsViewController.view.bounds.height
    
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 0,
      options: .curveEaseInOut) 
    {
      self.settingsViewController.view.frame = CGRect(
        x: self.view.bounds.minX,
        y: Constants.topMargin * 2,
        width: width,
        height: height)
    } completion: { _ in
      self.profileViewController.isOpened = true
      self.settingsViewController.isOpened = true
    }
  }
  
  func closeProfile() {
    let width = profileViewController.view.bounds.width
    let height = profileViewController.view.bounds.height
    
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 0,
      options: .curveEaseInOut)
    {
      self.profileViewController.view.frame = CGRect(
        x: self.view.bounds.minX,
        y: self.view.bounds.maxY - Constants.topMargin * 2,
        width: width,
        height: height)
    } completion: { _ in
      self.profileViewController.isOpened = false
      self.settingsViewController.isOpened = false
    }
  }
  
  func closeSettings() {
    let width = settingsViewController.view.bounds.width
    let height = settingsViewController.view.bounds.height
    
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 0,
      options: .curveEaseInOut)
    {
      self.settingsViewController.view.frame = CGRect(
        x: self.view.bounds.minX,
        y: self.view.bounds.maxY - Constants.topMargin,
        width: width,
        height: height)
    } completion: { _ in
      self.settingsViewController.isOpened = false
    }
  }
}

extension MainViewController: ProfileViewControllerDelegate {
  func profileViewControllerTapped() {
    if profileViewController.isOpened {
      closeSettings()
      closeProfile()
    } else {
      openProfile()
    }
  }
  
  private func profileAdjustY(_ y: Double) -> Double {
    return min(max(y, Constants.topMargin), view.bounds.maxY - Constants.topMargin * 2)
  }
  
  func profileViewControllerDragged(_ sender: UIPanGestureRecognizer) {
    
    if sender.state == .ended {
      let velocity = sender.velocity(in: view)
      
      if velocity.y < 0 {
        openProfile()
        
        if settingsViewController.isOpened {
          openSettings()
        }
      } else {
        closeSettings()
        closeProfile()
      }
      
      return
    } else if sender.state == .changed {
      
      let translation = sender.translation(in: view)
      let origin = profileViewController.view.frame.origin
      
      profileViewController.view.frame.origin = CGPoint(
        x: origin.x,
        y: profileAdjustY(origin.y + translation.y))
      
      if settingsViewController.isOpened {
        let profileY = profileViewController.view.frame.origin.y
        let settingY = settingsViewController.view.frame.origin.y
        settingsViewController.view.frame.origin.y = max(min(profileY + Constants.topMargin, settingY), profileY + 10)
      }
    }
    
    sender.setTranslation(.zero, in: view)
  }
}

extension MainViewController: SettingsViewControllerDelegate {
  func settingsViewControllerDidTapped() {
    if settingsViewController.isOpened {
      closeSettings()
    } else {
      openProfile()
      openSettings()
    }
  }
  
  private func settingsAdjustY(_ y: Double) -> Double {
    return min(max(y, Constants.topMargin * 2), view.bounds.maxY - Constants.topMargin)
  }
  
  func settingsViewControllerDragged(_ sender: UIPanGestureRecognizer) {
    
    if sender.state == .ended {
      let velocity = sender.velocity(in: view)
      
      if velocity.y < 0 {
        openProfile()
        openSettings()
      } else {
        closeSettings()
        
        if !profileViewController.isOpened {
          closeProfile()
        }
      }
      
      return
    } else if sender.state == .changed {
      
      let translation = sender.translation(in: view)
      let origin = settingsViewController.view.frame.origin
      
      settingsViewController.view.frame.origin = CGPoint(
        x: origin.x,
        y: settingsAdjustY(origin.y + translation.y))
      
      if !profileViewController.isOpened {
        let profileY = profileViewController.view.frame.origin.y
        let settingY = settingsViewController.view.frame.origin.y
        profileViewController.view.frame.origin.y = max(min(settingY - 10, profileY), settingY - Constants.topMargin)
      }
    }
    
    sender.setTranslation(.zero, in: view)
  }
}

#Preview {
  return MainViewController()
}
