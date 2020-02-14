//
//  EditVehicleVC.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

protocol EditVehicleDelegate {
    func didTapDone(vehicleName: String, vehicleId: String, vehicleFuelBrand: String, vehicleType: String)
}

class EditVehicleVC: UIViewController {
    
    var vehicle : Vehicle!
    
    let vehicleSelectField = FLRVehicleSelectView(frame: .zero)
    let vehicleNameTextField = FLRTextField(placeHolderText: PlaceHolders.vehicleName, returnKey: .next)
    let vehicleIdTextField = FLRTextField(placeHolderText: PlaceHolders.vehicleId, returnKey: .next)
    let vehicleFuelBrandTextField = FLRTextField(placeHolderText: PlaceHolders.vehicleFuelBrand, returnKey: .done)
    
    var vehicleDelegate : EditVehicleDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        createBarButtonItem()
        createDissmissKeyboardTapGesture()
        configureVehicleSelector()
        configureTextFields()
        defaultSelectedVehicle()
    }
    
    
    private func configureViewController(){
        navigationController?.navigationBar.barTintColor = Color.FLRBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        isModalInPresentation = true
        view.backgroundColor = .tertiarySystemBackground
    }
    
    
    private func createBarButtonItem() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction))
        navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    private func createDissmissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func doneButtonAction(){
        if vehicleNameTextField.text!.isEmpty || vehicleIdTextField.text!.isEmpty || vehicleFuelBrandTextField.text!.isEmpty {
            checkIsEmpty(textField: vehicleNameTextField)
            checkIsEmpty(textField: vehicleIdTextField)
            checkIsEmpty(textField: vehicleFuelBrandTextField)
            return
        }
        
        vehicleDelegate.didTapDone(vehicleName: vehicleNameTextField.text!, vehicleId: vehicleIdTextField.text!, vehicleFuelBrand: vehicleFuelBrandTextField.text!, vehicleType: vehicleSelectField.vehicleType)
        
        dismiss(animated: true)
    }
    
    
    @objc func cancelButtonAction() {
        dismiss(animated: true)
    }
    
    
    private func configureVehicleSelector(){
        view.addSubview(vehicleSelectField)
        
        let height = imageSize(view: self.view)
        NSLayoutConstraint.activate([vehicleSelectField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     vehicleSelectField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     vehicleSelectField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     vehicleSelectField.heightAnchor.constraint(equalToConstant: height+50),
        ])
    }
    
    
    private func defaultSelectedVehicle(){
        vehicleSelectField.vehicle1.layer.borderColor = UIColor.systemGray.cgColor
        
        switch vehicle.type {
        case "car":
            vehicleSelectField.vehicleType = "car"
            vehicleSelectField.vehicle1.layer.borderColor = Color.FLRBlue.cgColor
        case "motorcycle":
            vehicleSelectField.vehicleType = "motorcycle"
            vehicleSelectField.vehicle2.layer.borderColor = Color.FLRBlue.cgColor
        case "truck":
            vehicleSelectField.vehicleType = "truck"
            vehicleSelectField.vehicle3.layer.borderColor = Color.FLRBlue.cgColor
        case "tractor":
            vehicleSelectField.vehicleType = "tractor"
            vehicleSelectField.vehicle4.layer.borderColor = Color.FLRBlue.cgColor 
        default:
            return
        }
    }
    
    
    private func configureTextFields() {
        view.addSubview(vehicleNameTextField)
        view.addSubview(vehicleIdTextField)
        view.addSubview(vehicleFuelBrandTextField)
        vehicleNameTextField.delegate = self
        vehicleIdTextField.delegate = self
        vehicleFuelBrandTextField.delegate = self
        vehicleNameTextField.text = vehicle.name
        vehicleIdTextField.text = vehicle.id
        vehicleFuelBrandTextField.text = vehicle.fuelBrand
        vehicleIdTextField.autocapitalizationType = .allCharacters
        
        
        NSLayoutConstraint.activate([
            vehicleNameTextField.topAnchor.constraint(equalTo: vehicleSelectField.bottomAnchor, constant: 20),
            vehicleNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            vehicleNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            vehicleNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            vehicleIdTextField.topAnchor.constraint(equalTo: vehicleNameTextField.bottomAnchor, constant: 30),
            vehicleIdTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            vehicleIdTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            vehicleIdTextField.heightAnchor.constraint(equalToConstant: 50),
            
            vehicleFuelBrandTextField.topAnchor.constraint(equalTo: vehicleIdTextField.bottomAnchor, constant: 30),
            vehicleFuelBrandTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            vehicleFuelBrandTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            vehicleFuelBrandTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
}

extension EditVehicleVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty{
                textField.layer.borderColor = UIColor.systemRed.cgColor
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.systemGray.cgColor
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == vehicleNameTextField {
            textField.resignFirstResponder()
            vehicleIdTextField.becomeFirstResponder()
        } else if textField == vehicleIdTextField {
            textField.resignFirstResponder()
            vehicleFuelBrandTextField.becomeFirstResponder()
        } else if textField == vehicleFuelBrandTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

