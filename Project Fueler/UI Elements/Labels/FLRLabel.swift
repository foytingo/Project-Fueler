//
//  FLRLabel.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FLRLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
        configure()
    }
    
    
    private func configure(){
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
