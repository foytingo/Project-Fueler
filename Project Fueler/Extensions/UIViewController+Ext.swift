//
//  UIViewController+Ext.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(alertTitle: String, alertMessage: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: buttonTitle, style: .default)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func presentDeleteAlertOnMainThread(vehicle: Vehicle){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Texts.vehicleDeleteAlert, message: Texts.vehicleDeleteAlertMessage, preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: Texts.delete, style: .destructive) { (deleteAction) in
                CoreDataManager.updateWith(vehicle: vehicle, actionType: .remove) { [weak self]error in
                    guard self != nil else {return}
                    guard let error = error else {return}
                    self!.presentAlertOnMainThread(alertTitle: Texts.somethingWrong, alertMessage: error.rawValue, buttonTitle: Texts.ok)
                }
                self.navigationController?.popViewController(animated: true)
            }
            let cancelAction = UIAlertAction(title: Texts.cancel, style: .default) { (cancelAction) in
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func imageSize(view: UIView) -> CGFloat{
        let width = view.bounds.width
        let padding : CGFloat = 20
        let paddingImage: CGFloat = 5
        let itemSpacing: CGFloat = 15
        let fourImageSize = width - (2 * padding) - (2 * paddingImage) - (3 * itemSpacing)
        let imageSize = fourImageSize / 4
        
        return imageSize
    }
    
    
    func showEmptyStateView(with message: String, in tableView: UITableView) {
        let emptyStateView = FLREmptyStateView(message: message)
        tableView.backgroundView = emptyStateView
    }
    
    
    func checkIsEmpty(textField: UITextField){
        if textField.text!.isEmpty {
            textField.layer.borderColor = UIColor.systemRed.cgColor
            textField.resignFirstResponder()
        }
    }
    
    
    func setupTextFieldToolbar() -> UIToolbar{
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: Texts.done, style: .done, target: self, action: #selector(keyboardDoneButtonAction))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        return toolbar
    }
    
    
    @objc func keyboardDoneButtonAction(){
        self.view.endEditing(true)
    }
    
    
}

