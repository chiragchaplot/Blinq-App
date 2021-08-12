//
//  CustomButton.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ title: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.sizeToFit()
        self.backgroundColor = .black
        self.setTitle(title, for: .normal)
        //gradientButton(title, startColor: UIColor.yellow, endColor: UIColor.green)
    }
    
    func gradientButton(_ buttonText:String, startColor:UIColor, endColor:UIColor) {

        
        self.setTitle(buttonText, for: .normal)
        let gradient = CAGradientLayer()
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
        self.mask = self
        self.layer.borderWidth = 5.0
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
