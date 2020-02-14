//
//  AddFuelVC.swift
//  FuelerCore
//
//  Created by Murat Baykor on 28.01.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class AddFuelVC: UIViewController, UINavigationControllerDelegate {
    
    let fuelAmount = FLRTextField(placeHolderText: PlaceHolders.addFuel, fontSize: 35)
    let fuelVehicle = FLRLabel(textAlignment: .right, fontSize: 20, fontWeight: .medium, textColor: .label)
    let selectedVehicleLabel = FLRLabel(textAlignment: .left, fontSize: 20, fontWeight: .medium, textColor: .secondaryLabel)
    let changeVehicleButton = FLRButton(backgroundColor: Color.FLRBlue)
    let fuelReceiptPhotoButton = FLRButton(backgroundColor: Color.FLRBlue)
    
    let receiptView = UIImageView()
    let imagePicker = UIImagePickerController()
    
    var vehicles: [Vehicle]!
    var vehicleCount: Int!
    var selectedVehicleForFuel: Vehicle!
    var receiptPhotoData: Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBarButtonItem()
        configureViewController()
        createDissmissKeyboardTapGesture()
        configureTextFields()
        configureVehicleTextandButton()
        configureReceiptImageView()
        
        imagePicker.delegate = self
    }
    
    
    private func configureViewController(){
        navigationController?.navigationBar.barTintColor = Color.FLRBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        view.backgroundColor = .tertiarySystemBackground
    }
    
    
    private func createBarButtonItem(){
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction))
        navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc func cancelButtonAction(){
        dismiss(animated: true)
    }
    
    
    @objc func doneButtonAction(){
        fuelAmount.resignFirstResponder()
        if fuelAmount.text!.isEmpty {
            checkIsEmpty(textField: fuelAmount)
            return
        }
        
        if receiptView.image == nil {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Texts.addPhoto, message: Texts.addPhotoText, preferredStyle: .alert)
                let addAction = UIAlertAction(title: Texts.add, style: .default) { (addAction) in
                    self.addReceiptPhoto()
                }
                alert.addAction(addAction)
                
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let newFuel = Fuel(context: CoreDataManager.context)
        newFuel.amount = Int32(fuelAmount.text!) ?? 0
        newFuel.date = Date()
        newFuel.receiptData = receiptPhotoData!
        newFuel.parentVehicle = selectedVehicleForFuel
        
        CoreDataManager.updateWith(fuel: newFuel, actionType: .add) { [weak self] error in
            guard self != nil else { return }
            
            guard let error = error else {  return }
            self!.presentAlertOnMainThread(alertTitle: Texts.somethingWrong, alertMessage: error.rawValue, buttonTitle: Texts.ok)
        }
        
        dismiss(animated: true)
    }
    
    
    private func createDissmissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func configureTextFields(){
        view.addSubview(fuelAmount)
        fuelAmount.inputAccessoryView = setupTextFieldToolbar()
        fuelAmount.delegate = self
        fuelAmount.keyboardType = .asciiCapableNumberPad
        let padding : CGFloat = 40
        NSLayoutConstraint.activate([fuelAmount.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
                                     fuelAmount.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
                                     fuelAmount.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
                                     fuelAmount.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
        
    
    func configureReceiptImageView(){
        view.addSubview(receiptView)
        receiptView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([receiptView.topAnchor.constraint(equalTo: fuelReceiptPhotoButton.bottomAnchor, constant: 30),
                                     receiptView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
                                     receiptView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
                                     receiptView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    
    func configureVehicleTextandButton(){
        view.addSubview(selectedVehicleLabel)
        selectedVehicleLabel.text = Texts.selectedVehicle
        
        view.addSubview(fuelVehicle)
        selectedVehicleForFuel = vehicles[0]
        fuelVehicle.text = "\(selectedVehicleForFuel.name!) - \(selectedVehicleForFuel.fuelBrand!)"
        
        view.addSubview(changeVehicleButton)
        changeVehicleButton.setTitle(Texts.changeVehicle, for: .normal)
        changeVehicleButton.addTarget(self, action: #selector(showVehicleList), for: .touchUpInside)
        
        view.addSubview(fuelReceiptPhotoButton)
        fuelReceiptPhotoButton.setTitle(Texts.addPhoto, for: .normal)
        fuelReceiptPhotoButton.addTarget(self, action: #selector(addReceiptPhoto), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            selectedVehicleLabel.topAnchor.constraint(equalTo: fuelAmount.bottomAnchor, constant: 25),
            selectedVehicleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            selectedVehicleLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            selectedVehicleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            fuelVehicle.topAnchor.constraint(equalTo: fuelAmount.bottomAnchor, constant: 25),
            fuelVehicle.leadingAnchor.constraint(equalTo: selectedVehicleLabel.trailingAnchor),
            fuelVehicle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            fuelVehicle.heightAnchor.constraint(equalToConstant: 30),
            
            changeVehicleButton.topAnchor.constraint(equalTo: fuelVehicle.bottomAnchor, constant: 25),
            changeVehicleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            changeVehicleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            changeVehicleButton.heightAnchor.constraint(equalToConstant: 40),
            
            fuelReceiptPhotoButton.topAnchor.constraint(equalTo: changeVehicleButton.bottomAnchor, constant: 25),
            fuelReceiptPhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            fuelReceiptPhotoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            fuelReceiptPhotoButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    @objc func addReceiptPhoto() {
        DispatchQueue.main.async {
            self.fuelAmount.endEditing(true)
            let alert = UIAlertController(title: Texts.addPhoto, message: Texts.photoMethod, preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: Texts.takePhoto, style: .default) { (cameraAction) in
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
            let libraryAction = UIAlertAction(title: Texts.selectPhoto, style: .default) { (libraryAction) in
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: Texts.cancel, style: .cancel, handler: nil)
            
            alert.addAction(cameraAction)
            alert.addAction(libraryAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func showVehicleList(){
        if vehicleCount == 1{
            fuelAmount.resignFirstResponder()
            presentAlertOnMainThread(alertTitle: Texts.oneVehicle, alertMessage: Texts.oneVehicleDescription, buttonTitle: Texts.ok)
        } else {
            let destVC = VehicleListVC()
            let navController = UINavigationController(rootViewController: destVC)
            destVC.selectVehicleDelegate = self
            destVC.title = Texts.changeVehicle
            present(navController, animated: true)
        }
    }
}

extension AddFuelVC: SelectVehicleDelegate{
    func didSelectVehicle(selectedVehicle: Vehicle) {
        selectedVehicleForFuel = selectedVehicle
        DispatchQueue.main.async {
            self.fuelVehicle.text = "\(self.selectedVehicleForFuel.name!) - \(self.selectedVehicleForFuel.fuelBrand!)"
        } 
    }
    
}

extension AddFuelVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let data = NSData(data: image.jpegData(compressionQuality: 0.0)!)
            receiptPhotoData = data as Data
            
            let loadingImage = UIImage(data: data as Data)
            receiptView.image = loadingImage
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}

extension AddFuelVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stingRange = Range(range, in:currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stingRange, with: string)
        
        return updateText.count < 5
    }
    
    
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
    
}


