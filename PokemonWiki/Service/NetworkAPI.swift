//
//  NetworkAPI.swift
//  PokemonWiki
//
//  Created by Elvis Cheng (ESD - Software Trainee, Digital Solutions) on 5/7/2024.
//

import Foundation

class NetworkAPI {
    static func getPokemons() async -> PokemonListResponseDto? {
        do {
            let dto = try await NetworkManager.shared.request(method: .get, url: APIEndpoints.pokemon, of: PokemonListResponseDto.self)
            return dto
        } catch {
            print("[‼️] getCurrentWeatherReport() \(String(describing: error))")
            return nil
        }
    }
}
