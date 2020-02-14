//
//  FLRTabBarController.swift
//  Project Fueler
//
//  Created by Murat Baykor on 12.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FLRTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = Color.FLRBlue
        viewControllers = [createFuelPurchaseVC(), createVehicleNC()]
    }
    
    
    func createVehicleNC() -> UINavigationController {
        let vehiclesVC = VehiclesVC()
        vehiclesVC.title = Texts.vehicles
        vehiclesVC.tabBarItem = UITabBarItem(title: Texts.vehicles, image: UIImage(systemName: "rectangle.grid.1x2"), tag: 0)
        vehiclesVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        return UINavigationController(rootViewController: vehiclesVC)
    }
    
    
    func createFuelPurchaseVC() -> UINavigationController {
        let fuelPurchaseVC = FuelPurchasesVC()
        fuelPurchaseVC.title = Texts.fuels
        fuelPurchaseVC.tabBarItem = UITabBarItem(title: Texts.fuels, image: UIImage(systemName: "flame"), tag: 1)
        fuelPurchaseVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        return UINavigationController(rootViewController: fuelPurchaseVC)
    }

}
