//
//  Constants.swift
//  Project Fueler
//
//  Created by Murat Baykor on 12.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

enum Color {
    static let FLRBlue = UIColor(red:0.24, green:0.60, blue:0.80, alpha:1.0)
    static let FLRRed = UIColor(red:1.00, green:0.37, blue:0.44, alpha:1.0)
}

enum PlaceHolders {
    static let searchBar = "Search with vehicle name or id.".localized()
    static let vehicleName = "Enter vehicle's nickname or model".localized()
    static let vehicleId = "Enter vehicle's id".localized()
    static let vehicleFuelBrand = "Enter your prefered fuel brand".localized()
    static let addFuel = "Enter fuel amount".localized()
}

enum Texts {
    static let somethingWrong = "Something went wrong.".localized()
    static let ok = "Ok".localized()
    static let done = "Done".localized()
    static let cancel = "Cancel".localized()
    static let add = "Add".localized()
    static let change = "Change".localized()
    static let changeVehicle = "Change Vehicle".localized()
    static let oneVehicle = "You have one vehicle.".localized()
    static let oneVehicleDescription = "If you want to add fuel for different vehicle, go 'Vehicles' tab and add new vehicle.".localized()
    static let edit = "Edit".localized()
    static let editVehicleTitle = "Edit Vehicle".localized()
    static let editFuelTitle = "Edit Fuel Purchase".localized()
    static let delete = "Delete".localized()
    static let emtpyFuelState = "No fuel purchase added yet.".localized()
    static let emptyVehicleState = "No vehicle added yet.".localized()
    static let noVehicle = "No vehicle added".localized()
    static let addVehicleAlert = "Add vehicle in 'Vehicles' tab".localized()
    static let addFuelTitle = "Add Fuel Purchase".localized()
    static let addVehicleTitle = "Add Vehicle".localized()
    static let vehicleDetailTitle = "Vehicle Detail".localized()
    static let fuelDetailTitle = "Fuel Purchase Detail".localized()
    static let purchaseCount = "Fuel Purchase Count".localized()
    static let totalSpent = "Total Fuel Spent".localized()
    static let addPhoto = "Add Receipt Photo".localized()
    static let showPhoto = "Show Receipt".localized()
    static let showPhotoTitle = "Receipt Photo".localized()
    static let addPhotoText = "You didn't add receipt photo".localized()
    static let photoMethod = "Select method".localized()
    static let takePhoto = "Take a photo".localized()
    static let selectPhoto = "Select a photo".localized()
    static let vehicles = "Vehicles".localized()
    static let fuels = "Fuel Purchases".localized()
    static let vehicleDeleteAlert = "Are you sure?".localized()
    static let vehicleDeleteAlertMessage = "If you delete this vehicle, the fuel purchases you add of this vehicle will also be deleted.".localized()
    static let selectedVehicle = "Selected vehicle:".localized()
    
}
