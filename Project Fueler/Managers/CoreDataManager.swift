//
//  CoreDataManager.swift
//  Project Fueler
//
//  Created by Murat Baykor on 6.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit
import CoreData

enum PersistenceActionType {
    case add, remove
}

enum CoreDataManager {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func updateWith(vehicle: Vehicle, actionType: PersistenceActionType, completed: @escaping(FLRError?) -> Void){
        retrieveVehicles { (result) in
            switch result {
            case .success(let vehicles):
                var retrievedVehicles = vehicles
                
                switch actionType {
                case .add:
                    retrievedVehicles.append(vehicle)
                case .remove:
                    context.delete(vehicle)
                }
                
                completed(save())
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func updateWith(fuel: Fuel, actionType: PersistenceActionType, completed: @escaping(FLRError?) -> Void){
        retrieveFuels { (result) in
            switch result {
            case .success(let fuels):
                var retrievedFuels = fuels
                
                switch actionType {
                case .add:
                    retrievedFuels.append(fuel)
                case .remove:
                    context.delete(fuel)
                }
                
                completed(save())
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFuels(completed: @escaping(Result<[Fuel], FLRError>) -> Void){
        let request = NSFetchRequest<Fuel>(entityName: "Fuel")
        do{
            var fuels = try context.fetch(request)
            fuels.reverse()
            completed(.success(fuels))
        } catch {
            completed(.failure(.unableToFuels))
        }
    }
    
    
    static func retrieveVehicles(completed: @escaping(Result<[Vehicle], FLRError>) -> Void){
        let request = NSFetchRequest<Vehicle>(entityName: "Vehicle")
        do{
            let vehicles = try context.fetch(request)
            completed(.success(vehicles))
        } catch {
            completed(.failure(.unableToVehicles))
        }
    }
    
    
    static func save() -> FLRError? {
        do{
            try context.save()
            return nil
        } catch {
            return .unableToVehicles
        }
    }
    
}
