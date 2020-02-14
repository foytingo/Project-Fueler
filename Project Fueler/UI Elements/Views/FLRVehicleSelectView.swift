//
//  FLRVehicleSelectView.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FLRVehicleSelectView: UIView {
    
    let stackView = UIStackView()
    let vehicle1 = FLRVehicleImageView(vehicle: UIImage(named: "car")!, tag: 1)
    let vehicle2 = FLRVehicleImageView(vehicle: UIImage(named: "motorcycle")!, tag: 2)
    let vehicle3 = FLRVehicleImageView(vehicle: UIImage(named: "truck")!, tag: 3)
    let vehicle4 = FLRVehicleImageView(vehicle: UIImage(named: "tractor")!, tag: 4)
    
    var selectedVehicleTag = 1
    var vehicleType = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
        defaultSelectedVehicle()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        let vehicleImageArray = [vehicle1, vehicle2, vehicle3, vehicle4]
        for vehicleImage in vehicleImageArray {
            stackView.addArrangedSubview(vehicleImage)
            createImageTapRec(vehicleImage: vehicleImage)
        }
    }
    
    
    private func layoutUI(){
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding : CGFloat = 25
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
        
    
    private func createImageTapRec(vehicleImage: UIImageView){
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tap:)))
        vehicleImage.isUserInteractionEnabled = true
        vehicleImage.addGestureRecognizer(tap)
    }
    
    
    @objc private func imageTapped(tap: UITapGestureRecognizer){
        let tappedImage = tap.view as! UIImageView
        selectedVehicleTag = tappedImage.tag
    
        switch selectedVehicleTag {
        case 1:
            vehicle2.layer.borderColor = UIColor.systemGray.cgColor
            vehicle3.layer.borderColor = UIColor.systemGray.cgColor
            vehicle4.layer.borderColor = UIColor.systemGray.cgColor
            vehicle1.layer.borderColor = Color.FLRBlue.cgColor
            vehicleType = "car"
            
        case 2:
            vehicle1.layer.borderColor = UIColor.systemGray.cgColor
            vehicle3.layer.borderColor = UIColor.systemGray.cgColor
            vehicle4.layer.borderColor = UIColor.systemGray.cgColor
            vehicle2.layer.borderColor = Color.FLRBlue.cgColor
            vehicleType = "motorcycle"
            
        case 3:
            vehicle1.layer.borderColor = UIColor.systemGray.cgColor
            vehicle2.layer.borderColor = UIColor.systemGray.cgColor
            vehicle4.layer.borderColor = UIColor.systemGray.cgColor
            vehicle3.layer.borderColor = Color.FLRBlue.cgColor
            vehicleType = "truck"
            
        case 4:
            vehicle1.layer.borderColor = UIColor.systemGray.cgColor
            vehicle2.layer.borderColor = UIColor.systemGray.cgColor
            vehicle3.layer.borderColor = UIColor.systemGray.cgColor
            vehicle4.layer.borderColor = Color.FLRBlue.cgColor
            vehicleType = "tractor"
            
        default:
            return
        }
    }
    
    
    private func defaultSelectedVehicle(){
        vehicle1.layer.borderColor = Color.FLRBlue.cgColor
        vehicleType = "car"
    }
    
}
