//
//  FLRTextField.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FLRTextField: UITextField {

   override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(placeHolderText: String, returnKey : UIReturnKeyType) {
        super.init(frame: .zero)
        returnKeyType = returnKey
        placeholder = placeHolderText
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        configure()
    }
    
    
    init(placeHolderText: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        
        placeholder = placeHolderText
        font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        adjustsFontSizeToFitWidth = true
        configure()
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        
    }

}
