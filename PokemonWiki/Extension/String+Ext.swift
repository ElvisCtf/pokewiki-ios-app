//
//  String+Ext.swift
//  PokemonWiki
//
//  Created by Elvis Cheng (ESD - Software Trainee, Digital Solutions) on 10/7/2024.
//

import Foundation

extension String? {
    var safeValue: String {
        return self ?? ""
    }
}
