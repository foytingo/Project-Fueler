//
//  VehicleCell.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class VehicleCell: UITableViewCell {
    
    static let reuseID = "VehicleCell"
    
    let vehicleImage = FLRVehicleImageView(frame: .zero)
    let vehicleNameLabel = FLRLabel(textAlignment: .left, fontSize: 35, fontWeight: .medium, textColor: .label)
    let vehicleIdLabel = FLRLabel(textAlignment: .left, fontSize: 20, fontWeight: .regular, textColor: .secondaryLabel)
    let vehicleFuelBrandLabel = FLRLabel(textAlignment: .left, fontSize: 20, fontWeight: .regular, textColor: .secondaryLabel)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func set(vehicle: Vehicle){
        vehicleImage.image = UIImage(named: vehicle.type!)
        vehicleNameLabel.text = vehicle.name
        vehicleIdLabel.text = vehicle.id
        vehicleFuelBrandLabel.text = vehicle.fuelBrand
    }
    
    
    private func configure() {
        addSubview(vehicleImage)
        addSubview(vehicleNameLabel)
        addSubview(vehicleIdLabel)
        addSubview(vehicleFuelBrandLabel)
        
        backgroundColor = .tertiarySystemBackground
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 10
        let textImagePadding : CGFloat = 20
        let imageSize : CGFloat = 68
        
        NSLayoutConstraint.activate([
            vehicleImage.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            vehicleImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            vehicleImage.heightAnchor.constraint(equalToConstant: imageSize),
            vehicleImage.widthAnchor.constraint(equalToConstant: imageSize),
            
            vehicleNameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            vehicleNameLabel.leadingAnchor.constraint(equalTo: vehicleImage.trailingAnchor, constant: textImagePadding),
            vehicleNameLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            vehicleNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            vehicleIdLabel.topAnchor.constraint(equalTo: vehicleNameLabel.bottomAnchor, constant: padding),
            vehicleIdLabel.leadingAnchor.constraint(equalTo: vehicleImage.trailingAnchor, constant: textImagePadding),
            vehicleIdLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            
            vehicleFuelBrandLabel.topAnchor.constraint(equalTo: vehicleNameLabel.bottomAnchor, constant: padding),
            vehicleFuelBrandLabel.leadingAnchor.constraint(equalTo: vehicleIdLabel.trailingAnchor, constant: padding),
            vehicleFuelBrandLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
        ])
    }
    
}
