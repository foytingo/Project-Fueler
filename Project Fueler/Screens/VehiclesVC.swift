//
//  VehiclesVC.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class VehiclesVC: UIViewController {
    
    let addButton = FLRAddButton(frame: .zero)
    let tableView = UITableView()
    
    var vehicles: [Vehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureAddButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getVehicles()
    }
    
    
    private func getVehicles(){
        CoreDataManager.retrieveVehicles { [weak self] result in
            guard let self = self else { return }
            
            switch result{
                
            case .success(let vehicles):
                self.vehicles = vehicles
                if vehicles.isEmpty {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.showEmptyStateView(with: Texts.emptyVehicleState, in: self.tableView)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.tableView.backgroundView = nil
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentAlertOnMainThread(alertTitle: Texts.somethingWrong, alertMessage: error.rawValue, buttonTitle: Texts.ok)
            }
        }
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .tertiarySystemBackground
        navigationController?.navigationBar.barTintColor = Color.FLRBlue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
    private func configureAddButton(){
        tableView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                                     addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     addButton.widthAnchor.constraint(equalToConstant: 68),
                                     addButton.heightAnchor.constraint(equalToConstant: 68)
        ])
    }
    
    
    @objc func addButtonAction() {
        DispatchQueue.main.async {
            let destVC = AddVehicleVC()
            let navController = UINavigationController(rootViewController: destVC)
            destVC.title = Texts.addVehicleTitle
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.frame = view.bounds
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.register(VehicleCell.self, forCellReuseIdentifier: VehicleCell.reuseID)
    }
}


extension VehiclesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.reuseID) as! VehicleCell
        let vehicle = vehicles[indexPath.row]
        cell.set(vehicle: vehicle)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vehicleDetailVC = VehicleDetailVC()
        vehicleDetailVC.vehicle = vehicles[indexPath.row]
        self.navigationController?.pushViewController(vehicleDetailVC, animated: true)
    }
}
