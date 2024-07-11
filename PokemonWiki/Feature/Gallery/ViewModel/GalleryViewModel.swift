//
//  GalleryViewModel.swift
//  PokemonWiki
//
//  Created by Elvis Cheng (ESD - Software Trainee, Digital Solutions) on 5/7/2024.
//

import Foundation

final class GalleryViewModel {
    @MainActor @Published var pokemons = [PokemonModel]()
    @MainActor @Published var errorMessage = ""
    
    init() {}
    
    func getPokemons() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        if let dto = await NetworkAPI.getPokemons() {
            let pokemonIDs = dto.results ?? []
            var pokemonList = [PokemonModel]()
            for (i, item) in pokemonIDs.enumerated() {
                let image = await NetworkAPI.getPokemonImage(name: item.name.safeValue)
                let pokemon = PokemonModel(
                    id: i+1,
                    name: item.name.safeValue,
                    image: image ?? Data(),
                    url: item.url.safeValue
                )
                pokemonList.append(pokemon)
            }
            
            await MainActor.run { [pokemonList] in
                self.pokemons = pokemonList
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }
    
}
