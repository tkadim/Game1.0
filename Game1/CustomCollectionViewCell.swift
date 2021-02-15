//
//  CustomCollectionViewCell.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
  var cellAvatar: UITextField?
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.createComponents()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.createComponents()
  }
  
  private func createComponents() {
    self.cellAvatar = UITextField()
    self.cellAvatar = UITextField(frame: .zero)
    self.cellAvatar?.sizeToFit()
    self.cellAvatar?.textAlignment = .center
    self.cellAvatar?.borderStyle = .line
    self.cellAvatar?.isUserInteractionEnabled = false
    
    [self.cellAvatar].forEach({
      $0?.translatesAutoresizingMaskIntoConstraints = false
      self.contentView.addSubview($0 ?? UIView())
    })
    NSLayoutConstraint.activate([
      self.cellAvatar!.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.cellAvatar!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      self.cellAvatar!.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
      self.cellAvatar!.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
      
    ])
    
    
  }
  
    public func setModeltoUI(model: String ) {
    self.cellAvatar?.text = model
    
  }
}

