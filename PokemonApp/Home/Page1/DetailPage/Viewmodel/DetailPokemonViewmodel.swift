//
//  DetailPokemonViewmodel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 01/02/23.
//

import Foundation

class DetailPokemonViewmodel: BaseViewmodel {
    
    var alertPage: AlertPage?
    let coreDM: CoreDataManager = CoreDataManager.shared
    @Published var isPresentedAlert:Bool = false
    private let network:Network = Network()
    var callbackIsLoading: (() -> Void)?
    private var pokemon: PokemonItem!
    @Published var stats:Array<Stat> = Array<Stat>()
    @Published var ability:Array<Stat> = Array<Stat>()
    @Published var base_experience: Int? = 0
    private var abilities:[AbilitiesResponse] = []
    @Published var presentSheet = false
    public var abilityDetail:EffectEntries? = nil
    public var abilityNameSelected:String = ""

    func onAppear(from: any BaseView) {
        Analytics.page(type: .PokemonPage)                
        self.request()
    }
    
    func onAppearSheet(abilityName:String) {
        self.abilityNameSelected = abilityName
        Analytics.page(type: .PokemonDetailPageSheet)
        self.requestAbility(ability: abilityName)
    }
    
    func setPokemon(pokemon: PokemonItem){
        self.pokemon = pokemon
    }
    
    func tapAction(actionTag: ActionTag) {
        
    }
    
    func onLongPressGesture(pokemon:PokemonItem){
        let iStar = pokemon.star ?? false
        var msg = iStar ? "Rimosso dai preferiti" : "Aggiunto nei preferiti"
        let ok = NSLocalizedString("Ok", comment: "")
        let title = NSLocalizedString("notice", comment: "")
        pokemon.star = !iStar
        let result = coreDM.updateItem(item: pokemon)
        msg = result ? msg : NSLocalizedString("msgAlert2", comment: "")
        if result {
            request()
        }
        alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
        isPresentedAlert.toggle()
    }
    
    private func request(){
        self.callbackIsLoading?()
        guard let request = Api.detail(name: self.pokemon.name).toUrlRequest() else { return }
        self.network.request(request: request) { [weak self] (result:Result<PokemonDetailResponse, NetworkError>) in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.callbackIsLoading?()
                self.base_experience = response.base_experience
                _  = response.stats.map {
                    let value = $0.base_stat
                    let name = $0.stat.name
                    self.stats.append(Stat(name: name.uppercased(), base_Stat: value))
                }
                self.abilities = response.abilities
                _ = response.abilities.map{
                    let ability = $0.ability
                    self.ability.append(Stat(name: ability.name.uppercased(), base_Stat: 0))
                }
                break
            case .failure(let error):
                Log.log(value: error)
                self.callbackIsLoading?()
                break
            }
        }
    }
    
    private func requestAbility(ability:String){
        self.callbackIsLoading?()
        guard let request = Api.detailAbility(name: ability).toUrlRequest() else { return }
        self.network.request(request: request) { [weak self] (result:Result<AbilityDetailResponse, NetworkError>) in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.callbackIsLoading?()
                self.abilityDetail = response.effect_entries.filter {$0.language.name.lowercased() == "en"}.last
                self.presentSheet.toggle()
                break
            case .failure(let error):
                Log.log(value: error)
                self.callbackIsLoading?()
                break
            }
        }
    }
    
}
