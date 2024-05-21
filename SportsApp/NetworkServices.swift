//
//  NetworkServices.swift
//  SportsApp
//
//  Created by Omar  on 18/05/2024.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol NetworkServicesProtocol {
    func fetchTeamsData(leagueId: Int, completion: @escaping (LeagueTeamsResponse?, Error?) -> Void)

}

class NetworkServices : NetworkServicesProtocol{
    let apiKey = "f57878d825c89df62d445853dcdf0e4cfe1c1cd108eb2237ac13055246f330d6"
    func fetchTeamsData(leagueId: Int, completion: @escaping (LeagueTeamsResponse?, Error?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/football/"
        let parameters: [String: Any] = [
            "met": "Teams",
            "APIkey": apiKey,
            "leagueId": leagueId
        ]
        
        Alamofire.request(url, parameters: parameters).responseData { response in
            print(response)
            switch response.result {
            case .success(let data):
                do {
                    print("Received data: \(String(data: data, encoding: .utf8) ?? "Empty data")")
                    let teamsResponseDecoded = try JSONDecoder().decode(LeagueTeamsResponse.self, from: data)
                    completion(teamsResponseDecoded, nil)
//                    print(teamsResponseDecoded)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}
