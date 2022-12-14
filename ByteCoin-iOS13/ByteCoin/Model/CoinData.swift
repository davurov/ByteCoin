//
//  CoinData.swift
//  ByteCoin
//
//  Created by Abduraxmon on 15/10/22.


import Foundation
struct CoinData: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}

