//
//  GalleryViewModel.swift
//  PokemonWiki
//
//  Created by Elvis Cheng (ESD - Software Trainee, Digital Solutions) on 5/7/2024.
//

import Foundation

final class GalleryViewModel {
    @MainActor @Published var pokemons = [PokemonID]()
    @MainActor @Published var errorMessage = ""
    
    init() {}
    
    func getPokemons() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        if let dto = await NetworkAPI.getPokemons() {
            await MainActor.run {
                self.pokemons = dto.results ?? []
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }
}
