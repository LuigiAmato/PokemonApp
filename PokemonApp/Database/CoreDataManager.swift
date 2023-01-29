//
//  CoreDataManager.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    init() {
        self.persistentContainer = NSPersistentContainer(name: "console")
        self.persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Core data store failed \(error.localizedDescription)")
            }
        }
    }
    
    func saveItem(){
     
        do {
            try persistentContainer.viewContext.save()
        }
        catch {
            print("errore core data save item")
        }
    }
    
    func deleteItem(){
        do {
            //persistentContainer.viewContext.de()
        }
        catch {
            print("errore core data save item")
        }
    }
    
    func updateItem(){
        
    }
}
