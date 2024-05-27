//
//  NetworkServices.swift
//  SportsApp
//
//  Created by Omar  on 18/05/2024.
//

import Foundation
import Alamofire
//import SwiftyJSON
protocol NetworkServicesProtocol {
    func fetchTeamsData(leagueId: Int, completion: @escaping (LeagueTeamsResponse?, Error?) -> Void)
    func fetchTeamsDetails(teamId: Int, completion: @escaping (LeagueTeamsResponse?, Error?) -> Void)
    func fetchLeaguesData(sportType : String,compilitionHandler : @escaping (Leagues?,Error?)-> Void)
    func fetchUpcomingData(sportType : String,leagueId : Int,compilitionHandler : @escaping (Events?,Error?)-> Void)

    func fetchLatestEvent(sportType : String,leagueId : Int,compilitionHandler : @escaping (Events?,Error?)-> Void)

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
//            print(response)
            switch response.result {
            case .success(let data):
                do {
//                    print("Received data: \(String(data: data, encoding: .utf8) ?? "Empty data")")
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
   //leagues
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
    func fetchUpcomingData(sportType: String, leagueId : Int, compilitionHandler: @escaping (Events?, Error?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&&leagueId=\(leagueId)&from=2024-05-18&to=2024-06-30&APIkey=\(apiKey)"
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
//                    print("Received data in upcoming: \(String(data: data, encoding: .utf8) ?? "Empty data")")
                    let upcoming = try JSONDecoder().decode(Events.self, from: data)
//                    print("after decode in upcoming\(upcoming)")
                    compilitionHandler(upcoming, nil)
                } catch {
                    compilitionHandler(nil, error)
                }
            case .failure(let error):
                compilitionHandler(nil, error)
            }
        }
        
    }
    func fetchLatestEvent(sportType: String, leagueId: Int, compilitionHandler: @escaping (Events?, Error?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&&leagueId=\(leagueId)&from=2024-02-23&to=2024-05-23&APIkey=\(apiKey)"
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
//                    print("Received data in latest: \(String(data: data, encoding: .utf8) ?? "Empty data")")
                    let latest = try JSONDecoder().decode(Events.self, from: data)
//                    print("after decode in latest \(latest)")
                    compilitionHandler(latest, nil)
                } catch {
                    compilitionHandler(nil, error)
                }
            case .failure(let error):
                compilitionHandler(nil, error)
            }
        }
    }
    
    // fetchTeamDetails
    func fetchTeamsDetails(teamId: Int, completion: @escaping (LeagueTeamsResponse?, Error?) -> Void)
    {
        let url = "https://apiv2.allsportsapi.com/football/"
        let parameters: [String: Any] = [
            "met": "Teams",
            "APIkey": apiKey,
            "teamId": teamId
        ]
        
        Alamofire.request(url, parameters: parameters).responseData { response in
//            print(response)
            switch response.result {
            case .success(let data):
                do {
//                    print("Received data: \(String(data: data, encoding: .utf8) ?? "Empty data")")
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
