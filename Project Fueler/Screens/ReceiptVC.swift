//
//  ReceiptVC.swift
//  FuelerCore
//
//  Created by Murat Baykor on 29.01.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class ReceiptVC: UIViewController {
    
    var imageView = UIImageView()
    var receiptImageData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        createBarButtonItem()
        configureReceiptView()
    }
    
    
    private func configureViewController(){
        navigationController?.navigationBar.barTintColor = Color.FLRBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        view.backgroundColor = .tertiarySystemBackground
    }
    
    
    private func createBarButtonItem(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc func doneButtonAction(){
        dismiss(animated: true)
    }
    
    
    private func configureReceiptView(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 360),
            imageView.heightAnchor.constraint(equalToConstant: 540)
        ])
        
        imageView.image = UIImage(data: receiptImageData as Data)
    }
}
