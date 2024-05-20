//
//  NetworkServices.swift
//  SportsApp
//
//  Created by Omar  on 18/05/2024.
//

import Foundation
import Alamofire
protocol NetworkServicesProtocol {
    func fetchLeaguesData(sportType : String,compilitionHandler : @escaping (Leagues?,Error?)-> Void)
}

class NetworkServices : NetworkServicesProtocol{
    let apiKey = "f57878d825c89df62d445853dcdf0e4cfe1c1cd108eb2237ac13055246f330d6"
    
    static let shared = NetworkServices()
        
        
    

    func fetchLeaguesData(sportType: String, compilitionHandler completionHandler: @escaping (Leagues?, Error?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sportType)?met=Leagues&APIkey=\(apiKey)"
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let leagues = try JSONDecoder().decode(Leagues.self, from: data)
                    completionHandler(leagues, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }

}
