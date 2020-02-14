//
//  FuelPurchaseDetailVC.swift
//  Project Fueler
//
//  Created by Murat Baykor on 7.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FuelPurchaseDetailVC: UIViewController {
    
    var fuel : Fuel!
    
    var imageView = UIImageView()
    let fuelDateLabel = FLRLabel(textAlignment: .center, fontSize: 20, fontWeight: .medium, textColor: .secondaryLabel)
    let fuelAmountLabel = FLRLabel(textAlignment: .center, fontSize: 35, fontWeight: .medium, textColor: .label)
    let fuelVehicleLabel = FLRLabel(textAlignment: .center, fontSize: 20, fontWeight: .medium, textColor: .secondaryLabel)
    let showReceiptButton = FLRButton(backgroundColor: Color.FLRBlue)
    let deletefuelButton = FLRButton(backgroundColor: Color.FLRRed)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureLabels()
        configureButtons()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popToRootViewController(animated: false)
    }
    
    
    private func configureViewController(){
        view.backgroundColor = .tertiarySystemBackground
        title = Texts.fuelDetailTitle
        navigationController?.navigationBar.barTintColor = Color.FLRBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    
    private func configureLabels(){
        view.addSubview(fuelDateLabel)
        view.addSubview(fuelAmountLabel)
        view.addSubview(fuelVehicleLabel)
        
        let currencySymbol = Locale.current.currencySymbol!
        
        fuelDateLabel.text = fuel.date!.stringFromDate()
        fuelAmountLabel.text = "\(currencySymbol)\(fuel.amount) - \(fuel.parentVehicle?.fuelBrand ?? "error")"
        fuelVehicleLabel.text = "\(fuel.parentVehicle?.name ?? "error") - \(fuel.parentVehicle?.id ?? "error")"
        
        NSLayoutConstraint.activate([
            fuelDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            fuelDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            fuelDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            fuelDateLabel.heightAnchor.constraint(equalToConstant: 25),
            
            fuelAmountLabel.topAnchor.constraint(equalTo: fuelDateLabel.bottomAnchor, constant: 20),
            fuelAmountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            fuelAmountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            fuelAmountLabel.heightAnchor.constraint(equalToConstant: 40),
            
            fuelVehicleLabel.topAnchor.constraint(equalTo: fuelAmountLabel.bottomAnchor, constant: 20),
            fuelVehicleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            fuelVehicleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            fuelVehicleLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    
    private func configureButtons(){
        view.addSubview(showReceiptButton)
        view.addSubview(deletefuelButton)
        
        showReceiptButton.addTarget(self, action: #selector(pushReceiptVC), for: .touchUpInside)
        deletefuelButton.addTarget(self, action: #selector(deleteFuel), for: .touchUpInside)
        
        showReceiptButton.setTitle(Texts.showPhoto, for: .normal)
        deletefuelButton.setTitle(Texts.delete, for: .normal)
        
        NSLayoutConstraint.activate([
            showReceiptButton.topAnchor.constraint(equalTo: fuelVehicleLabel.bottomAnchor, constant: 73),
            showReceiptButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            showReceiptButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            showReceiptButton.heightAnchor.constraint(equalToConstant: 50),
            
            deletefuelButton.topAnchor.constraint(equalTo: showReceiptButton.bottomAnchor, constant: 32),
            deletefuelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            deletefuelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            deletefuelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    @objc func pushReceiptVC(){
        let destVC = ReceiptVC()
        let navController = UINavigationController(rootViewController: destVC)
        destVC.title = Texts.showPhotoTitle
        destVC.receiptImageData = fuel.receiptData
        present(navController, animated: true)
    }
    
    
    @objc func deleteFuel() {
        CoreDataManager.updateWith(fuel: fuel, actionType: .remove) { [weak self]error in
            guard self != nil else {return}
            guard let error = error else {return}
            self!.presentAlertOnMainThread(alertTitle: Texts.somethingWrong, alertMessage: error.rawValue, buttonTitle: Texts.ok)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func configureReceiptView(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        imageView.image = UIImage(data: fuel.receiptData! as Data)
    }
    
}

