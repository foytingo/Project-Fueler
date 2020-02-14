//
//  FuelPurchaseCell.swift
//  Project Fueler
//
//  Created by Murat Baykor on 7.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FuelPurchaseCell: UITableViewCell {

    static let reuseID = "FuelPurchaseCell"
    
    let fuelAmount = FLRLabel(textAlignment: .center, fontSize: 30, fontWeight: .medium, textColor: .label)
    let fuelDate = FLRLabel(textAlignment: .right, fontSize: 14, fontWeight: .light, textColor: .secondaryLabel)
    let fuelVehicleAndBrand = FLRLabel(textAlignment: .left, fontSize: 24, fontWeight: .light, textColor: .secondaryLabel)
    
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
    
  
    func set(fuel: Fuel) {
        let currencySymbol = Locale.current.currencySymbol!
        let parentVehicle = fuel.parentVehicle
        fuelAmount.text = "\(currencySymbol)\(fuel.amount)"
        fuelDate.text = fuel.date!.stringFromDate()
        fuelVehicleAndBrand.text = "\(parentVehicle?.name ?? "error") - \(parentVehicle?.fuelBrand ?? "error")"
    }
    
    
    private func configure(){
            addSubview(fuelAmount)
            addSubview(fuelDate)
            addSubview(fuelVehicleAndBrand)
            
            backgroundColor = .tertiarySystemBackground
            accessoryType = .disclosureIndicator
            
            NSLayoutConstraint.activate([
                fuelAmount.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                fuelAmount.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                fuelAmount.trailingAnchor.constraint(equalTo: fuelDate.leadingAnchor, constant: -20),
                fuelAmount.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
                
                fuelDate.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                fuelDate.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 110),
                fuelDate.heightAnchor.constraint(equalToConstant: 20),
                
                fuelVehicleAndBrand.topAnchor.constraint(equalTo: fuelDate.bottomAnchor, constant: 10),
                fuelVehicleAndBrand.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 110),
                fuelVehicleAndBrand.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            ])
        }
    }
