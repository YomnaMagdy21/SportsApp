//
//  Leagues.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/19/24.
//

import Foundation

struct Leagues: Decodable {
    var success: Int?
    var result: [League]?
}


struct League: Decodable {
    var league_key: Int?
    var league_name: String?
    var league_logo : String?
    var sportType : String?

   
}
