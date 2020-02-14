//
//  FuelPurchasesVC.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FuelPurchasesVC: UIViewController {
    
    let addButton = FLRAddButton(frame: .zero)
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    var vehicles: [Vehicle] = []
    var fuels: [Fuel] = []
    var filteredFuels: [Fuel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureSearchBar()
        configureAddButton()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getVehicles()
        getFuels()
        
        if searchController.searchBar.text != nil {
            filteredFuelWithSearchbarText()
        }
        
    }

    
    private func getVehicles(){
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
    
    
    private func getFuels(){
        CoreDataManager.retrieveFuels { [weak self] result in
            guard let self = self else { return }
            
            switch result{
                
            case .success(let fuels):
                self.fuels = fuels
                if fuels.isEmpty {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tableView.tableHeaderView?.isHidden = true
                        self.showEmptyStateView(with: Texts.emtpyFuelState , in: self.tableView)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.tableView.backgroundView = nil
                        self.tableView.tableHeaderView?.isHidden = false
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentAlertOnMainThread(alertTitle: Texts.somethingWrong, alertMessage: error.rawValue, buttonTitle: Texts.ok)
            }
        }
    }
    
    
    private func filteredFuelWithSearchbarText() {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFuels = fuels.filter {
            ($0.parentVehicle?.name?.lowercased().contains(filter.lowercased()))! || ($0.parentVehicle?.id?.lowercased().trimmingCharacters(in: .whitespaces).contains(filter.lowercased()))!
        }
        
        fuels = filteredFuels
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        if vehicles.isEmpty {
            presentAlertOnMainThread(alertTitle: Texts.noVehicle, alertMessage: Texts.addVehicleAlert, buttonTitle: Texts.ok)
            return
        }
        DispatchQueue.main.async {
            let destVC = AddFuelVC()
            let navController = UINavigationController(rootViewController: destVC)
            destVC.title = Texts.addFuelTitle
            destVC.vehicles = self.vehicles
            destVC.vehicleCount = self.vehicles.count
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }
    }
    
    
    private func configureSearchBar(){
        self.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = .tertiarySystemBackground
        searchController.searchBar.backgroundColor = Color.FLRBlue
        searchController.searchBar.placeholder = PlaceHolders.searchBar
        searchController.searchBar.tintColor = Color.FLRBlue
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
       
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
       
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.frame = view.bounds
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView = UIView()
        
        tableView.register(FuelPurchaseCell.self, forCellReuseIdentifier: FuelPurchaseCell.reuseID)
    }
    
}

extension FuelPurchasesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FuelPurchaseCell.reuseID) as! FuelPurchaseCell
        let fuel = fuels[indexPath.row]
        cell.set(fuel: fuel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fuelPurchaseDetailVC = FuelPurchaseDetailVC()
        fuelPurchaseDetailVC.fuel = fuels[indexPath.row]
        
        self.navigationController?.pushViewController(fuelPurchaseDetailVC, animated: true)
    }
    
}

extension FuelPurchasesVC: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredFuelWithSearchbarText()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getFuels()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            getFuels()
            
            
        }
    }
    
}
