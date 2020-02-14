//
//  FLRAddButton.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FLRAddButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        setImage(UIImage(systemName: "plus"), for: .normal)
        tintColor = .white
        backgroundColor = Color.FLRBlue
        frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

}
