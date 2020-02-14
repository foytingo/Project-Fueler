//
//  FLRVehicleImageView.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FLRVehicleImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    init(vehicle: UIImage, tag: Int){
        super.init(frame: .zero)
        configure()
        self.image = vehicle
        self.tag = tag
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
