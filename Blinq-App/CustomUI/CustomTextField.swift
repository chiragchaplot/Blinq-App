//
//  CustomTextField.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    let insets: UIEdgeInsets
    
    init(inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)) {
        self.insets = inset
        super.init(frame: .zero)
        self.backgroundColor = UIColor(hex: "#9ae16d")
        self.textColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.returnKeyType = .next
        self.isAccessibilityElement = true
        self.accessibilityTraits = .adjustable
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    
}
