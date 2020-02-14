//
//  VehicleListVC.swift
//  Project Fueler
//
//  Created by Murat Baykor on 7.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

protocol SelectVehicleDelegate {
    func didSelectVehicle(selectedVehicle: Vehicle)
}

class VehicleListVC: UIViewController {
    
    var vehicles = [Vehicle]()
    
    var tableView: UITableView!
    
    var selectVehicleDelegate: SelectVehicleDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        createBarButtonItem()
        configureTableView()
        getVehicles()
    }
    
    func configureViewController(){
        navigationController?.navigationBar.barTintColor = Color.FLRBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        isModalInPresentation = true
        view.backgroundColor = .tertiarySystemBackground
    }
    
    
    func createBarButtonItem(){
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction))
        navigationItem.leftBarButtonItem = cancelButton
        
    }
    
    
    @objc func cancelButtonAction(){
        dismiss(animated: true)
    }
    
    
    func configureTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(VehicleCell.self, forCellReuseIdentifier: VehicleCell.reuseID)
    }
    
    
    func getVehicles(){
        CoreDataManager.retrieveVehicles { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let vehicles):
                self.vehicles = vehicles
            case .failure(let error):
                self.presentAlertOnMainThread(alertTitle: Texts.somethingWrong, alertMessage: error.rawValue, buttonTitle: Texts.ok)
            }
        }
    }
    
}

extension VehicleListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vehicles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.reuseID, for: indexPath) as! VehicleCell
        let vehicle = vehicles[indexPath.row]
        cell.set(vehicle: vehicle)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectVehicleDelegate.didSelectVehicle(selectedVehicle: vehicles[indexPath.row])
        dismiss(animated: true)
    }
}
