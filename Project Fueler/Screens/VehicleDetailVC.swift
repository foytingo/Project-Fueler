//
//  VehicleDetailVC.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class VehicleDetailVC: UIViewController {
    
    var vehicle: Vehicle!
    var filteredFuels: [Fuel] = []
    
    let vehilceTypeImage = FLRVehicleImageView(frame: .zero)
    let vehicleNameLabel = FLRLabel(textAlignment: .center, fontSize: 25, fontWeight: .medium, textColor: .label)
    let vehicleDetailLabel = FLRLabel(textAlignment: .center, fontSize: 20, fontWeight: .medium, textColor: .systemGray)
    let totalFuelPurchaseCountLabel = FLRLabel(textAlignment: .center, fontSize: 16, fontWeight: .medium, textColor: .systemGray)
    let totalFuelPurchase = FLRLabel(textAlignment: .center, fontSize: 16, fontWeight: .medium, textColor: .systemGray)
    let totalSpentLabel = FLRLabel(textAlignment: .center, fontSize: 16, fontWeight: .medium, textColor: .systemGray)
    let totalSpent = FLRLabel(textAlignment: .center, fontSize: 16, fontWeight: .medium, textColor: .systemGray)
    
    
    let editVehicleButton = FLRButton(backgroundColor: Color.FLRBlue)
    let deleteVehicleButton = FLRButton(backgroundColor: Color.FLRRed)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFuels()
        configureViewController()
        configureTextLabels()
        configureButtons()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popToRootViewController(animated: false)
    }
    
    
    private func configureViewController(){
        view.backgroundColor = .tertiarySystemBackground
        title = Texts.vehicleDetailTitle
        navigationController?.navigationBar.barTintColor = Color.FLRBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    
    private func configureTextLabels(){
        view.addSubview(vehilceTypeImage)
        view.addSubview(vehicleNameLabel)
        view.addSubview(vehicleDetailLabel)
        view.addSubview(totalFuelPurchaseCountLabel)
        view.addSubview(totalFuelPurchase)
        view.addSubview(totalSpentLabel)
        view.addSubview(totalSpent)

        setVehicleDetail()
        
        NSLayoutConstraint.activate([
            vehilceTypeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            vehilceTypeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vehilceTypeImage.widthAnchor.constraint(equalToConstant: 100),
            vehilceTypeImage.heightAnchor.constraint(equalToConstant: 100),
            
            vehicleNameLabel.topAnchor.constraint(equalTo: vehilceTypeImage.bottomAnchor, constant: 8),
            vehicleNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            vehicleNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            vehicleNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            vehicleDetailLabel.topAnchor.constraint(equalTo: vehicleNameLabel.bottomAnchor, constant: 8),
            vehicleDetailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            vehicleDetailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            vehicleDetailLabel.heightAnchor.constraint(equalToConstant: 25),
            
            totalFuelPurchaseCountLabel.topAnchor.constraint(equalTo: vehicleDetailLabel.bottomAnchor, constant: 25),
            totalFuelPurchaseCountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            totalFuelPurchaseCountLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -12.5),
            totalFuelPurchaseCountLabel.heightAnchor.constraint(equalToConstant: 25),
            
            totalSpentLabel.topAnchor.constraint(equalTo: vehicleDetailLabel.bottomAnchor, constant: 25),
            totalSpentLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 12.5),
            totalSpentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            totalSpentLabel.heightAnchor.constraint(equalToConstant: 25),
            
            totalFuelPurchase.topAnchor.constraint(equalTo: totalFuelPurchaseCountLabel.bottomAnchor, constant: 4),
            totalFuelPurchase.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            totalFuelPurchase.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -12.5),
            totalFuelPurchase.heightAnchor.constraint(equalToConstant: 25),
            
            totalSpent.topAnchor.constraint(equalTo: totalFuelPurchaseCountLabel.bottomAnchor, constant: 4),
            totalSpent.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 12.5),
            totalSpent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            totalSpent.heightAnchor.constraint(equalToConstant: 25)
            
            
            
        ])
    }
    
    
    private func setVehicleDetail(){
        vehilceTypeImage.image = UIImage(named: vehicle.type!)
        vehicleNameLabel.text = vehicle.name
        vehicleDetailLabel.text = "\(vehicle.id!) - \(vehicle.fuelBrand!)"
        totalFuelPurchaseCountLabel.text = Texts.purchaseCount
        totalFuelPurchase.text = String(vehicle.fuels!.count)
        totalSpentLabel.text = Texts.totalSpent
        let currencySymbol = Locale.current.currencySymbol!
        totalSpent.text = "\(currencySymbol) \(calculateTotalSpent(fuelArray: filteredFuels))"
    }
    
    
    private func configureButtons(){
        
        view.addSubview(editVehicleButton)
        view.addSubview(deleteVehicleButton)
        
        editVehicleButton.addTarget(self, action: #selector(pushEditVehicleVC), for: .touchUpInside)
        deleteVehicleButton.addTarget(self, action: #selector(deleteVehicle), for: .touchUpInside)
        
        editVehicleButton.setTitle(Texts.edit, for: .normal)
        deleteVehicleButton.setTitle(Texts.delete, for: .normal)
        
        NSLayoutConstraint.activate([
            editVehicleButton.topAnchor.constraint(equalTo: totalFuelPurchase.bottomAnchor, constant: 64),
            editVehicleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            editVehicleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            editVehicleButton.heightAnchor.constraint(equalToConstant: 50),
            
            deleteVehicleButton.topAnchor.constraint(equalTo: editVehicleButton.bottomAnchor, constant: 32),
            deleteVehicleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            deleteVehicleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            deleteVehicleButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func pushEditVehicleVC(){
        let destVC = EditVehicleVC()
        let navController = UINavigationController(rootViewController: destVC)
        destVC.title = Texts.editVehicleTitle
        destVC.vehicleDelegate = self
        destVC.vehicle = vehicle
        present(navController, animated: true)
    }
    
    @objc func deleteVehicle() {
        presentDeleteAlertOnMainThread(vehicle: vehicle)
    }
    
    
    
    
    
    private func getFuels(){
        CoreDataManager.retrieveFuels { [weak self] result in
            guard let self = self else { return }
            
            switch result{
                
            case .success(let fuels):
                guard let filter = self.vehicle.name, !filter.isEmpty else { return }
                self.filteredFuels = fuels.filter { ($0.parentVehicle?.name?.lowercased().contains(filter.lowercased()))! }
                
            case .failure(let error):
                self.presentAlertOnMainThread(alertTitle: Texts.somethingWrong, alertMessage: error.rawValue, buttonTitle: Texts.ok)
            }
        }
    }
    
    
    private func calculateTotalSpent(fuelArray: [Fuel]) -> Int32{
        var totalSpent: Int32 = 0
        for fuel in fuelArray {
            totalSpent += fuel.amount
        }
        return totalSpent
    }
    
}

extension VehicleDetailVC: EditVehicleDelegate {
    
    func didTapDone(vehicleName: String, vehicleId: String, vehicleFuelBrand: String, vehicleType: String) {
        vehicle.name = vehicleName
        vehicle.id = vehicleId
        vehicle.fuelBrand = vehicleFuelBrand
        vehicle.type = vehicleType
        
        CoreDataManager.updateWith(vehicle: vehicle, actionType: .add) { [weak self] error in
            guard self != nil else { return }
            
            guard let error = error else { return }
            self!.presentAlertOnMainThread(alertTitle: Texts.somethingWrong, alertMessage: error.rawValue, buttonTitle: Texts.ok)
        }
        
        setVehicleDetail()
    }
    
    
}
