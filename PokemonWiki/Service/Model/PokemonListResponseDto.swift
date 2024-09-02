//
//  PokemonListResponseDto.swift
//  PokemonWiki
//
//  Created by Elvis Cheng on 5/7/2024.
//

import Foundation

// MARK: - PokemonListResponseDto
struct PokemonListResponseDto: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonID]?
}

// MARK: - Result
struct PokemonID: Codable {
    let name: String?
    let url: String?
}
