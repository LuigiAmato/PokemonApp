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
    var lastDeckPokemon:Array<Pokemon> = []
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "console")
        self.persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Core data store failed \(error.localizedDescription)")
            }
        }
    }
    
    func getDeck()->[PokemonItem]{
    
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        do {
            lastDeckPokemon = try persistentContainer.viewContext.fetch(fetchRequest)
            let list = lastDeckPokemon.map(
                {
                    let pokemon:Pokemon = $0
                    let pokemonItem = PokemonItem(id: pokemon.id ?? UUID(), name: pokemon.name ?? "", offset: pokemon.offset, urlData: pokemon.urlData, urlImage: pokemon.urlImage ?? "",star: pokemon.star)
                    return pokemonItem
                }
            )
            
            return list
        }
        catch {
            print("errore core data getDeck")
            return []
        }
    }
    
    func saveItem(item:PokemonItem){
        let pokemonItem = Pokemon(context:persistentContainer.viewContext)
        pokemonItem.id = item.id
        pokemonItem.name = item.name
        pokemonItem.offset =  item.offset
        pokemonItem.urlData = item.urlData
        pokemonItem.urlImage = item.urlImage
        do {
            try persistentContainer.viewContext.save()
        }
        catch {
            print("errore core data save item")
        }
    }
    
    func deleteItem(name:String){
        let getAllPokemon = self.getDeck()
        let pokemonItem = Pokemon(context:persistentContainer.viewContext)
        pokemonItem.name = name
        pokemonItem.id = UUID()
        persistentContainer.viewContext.delete(pokemonItem)
        do {
            try persistentContainer.viewContext.save()
        }
        catch {
            print("errore core data delete item")
            persistentContainer.viewContext.rollback()
        }
    }
    
    func updateItem(item:PokemonItem)->Bool{
        let pokemonDb = lastDeckPokemon.last {$0.name == item.name}
        pokemonDb?.star = (item.star ?? false)
    
        do {
            try persistentContainer.viewContext.save()
            return true
        }
        catch {
            print("errore core data update item")
            persistentContainer.viewContext.rollback()
            return false
        }
    }
}
