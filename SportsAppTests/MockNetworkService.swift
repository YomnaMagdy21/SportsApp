//
//  MockNetworkService.swift
//  SportsAppTests
//
//  Created by Yomna Magdy  on 5/28/24.
//

import Foundation

@testable import SportsApp

class MockNetworkService{
    var leagues = Leagues()
    var upcoming = Events()
    var leagueTeamsResponse : LeagueTeamsResponse?
   
//   var shouldReturnError : Bool
//   init(shouldReturnError: Bool) {
//
//       self.shouldReturnError = shouldReturnError
//   }
//
    let fakeLeagueData =  "{\"success\":1,\"result\":[{\"league_key\":4,\"league_name\":\"UEFA Europa League\",\"country_key\":1,\"country_name\":\"eurocups\",\"league_logo\":\"\",\"country_logo\":null}]}"
    let fakeUpcomingData = "{\"success\":1,\"result\":[{\"event_key\":1392086,\"event_date\":\"2024-06-02\",\"event_time\":\"20:30\",\"event_home_team\":\"Venezia\",\"home_team_key\":5007,\"event_away_team\":\"Cremonese\",\"away_team_key\":4998,\"event_halftime_result\":\"\",\"event_final_result\":\"-\",\"event_ft_result\":\"\",\"event_penalty_result\":\"\",\"event_status\":\"\",\"country_name\":\"Italy\",\"league_name\":\"Serie B - Promotion Play-offs - Final\",\"league_key\":206,\"league_round\":\"Final\",\"league_season\":\"2023/2024\",\"event_live\":\"0\",\"event_stadium\":\"Stadio Pierluigi Penzo (Venezia)\",\"event_referee\":\"\",\"home_team_logo\":\"https://apiv2.allsportsapi.com/logo/5007_venezia.jpg\",\"away_team_logo\":\"https://apiv2.allsportsapi.com/logo/4998_cremonese.jpg\",\"event_country_key\":5,\"league_logo\":\"https://apiv2.allsportsapi.com/logo/logo_leagues/206_serie-b.png\",\"country_logo\":\"https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png\",\"event_home_formation\":\"\",\"event_away_formation\":\"\",\"fk_stage_key\":6086,\"stage_name\":\"Promotion Play-offs - Final\",\"league_group\":null,\"goalscorers\":[],\"substitutes\":[],\"cards\":[],\"vars\":{\"home_team\":[],\"away_team\":[]},\"lineups\":{\"home_team\":{\"starting_lineups\":[],\"substitutes\":[],\"coaches\":[],\"missing_players\":[]},\"away_team\":{\"starting_lineups\":[],\"substitutes\":[],\"coaches\":[],\"missing_players\":[]}},\"statistics\":[]}]}"
    let fakeLeagueTeamsResponse = "{\"success\":1,\"result\":[{\"team_key\":4977,\"team_name\":\"Spezia\",\"team_logo\":\"https://apiv2.allsportsapi.com/logo/4977_spezia.jpg\",\"players\":[{\"player_key\":3497989564,\"player_image\":\"https://apiv2.allsportsapi.com/logo/players/25768_a-reca.jpg\",\"player_name\":\"A. Reca\",\"player_number\":\"13\",\"player_country\":null,\"player_type\":\"Defenders\",\"player_age\":\"28\",\"player_match_played\":\"14\",\"player_goals\":\"4\",\"player_yellow_cards\":\"2\",\"player_red_cards\":\"0\",\"player_injured\":\"No\",\"player_substitute_out\":\"6\",\"player_substitutes_on_bench\":\"4\",\"player_assists\":\"0\",\"player_birthdate\":\"1995-06-17\",\"player_is_captain\":\"0\",\"player_shots_total\":\"\",\"player_goals_conceded\":\"0\",\"player_fouls_committed\":\"1\",\"player_tackles\":\"3\",\"player_blocks\":\"\",\"player_crosses_total\":\"8\",\"player_interceptions\":\"4\",\"player_clearances\":\"2\",\"player_dispossesed\":\"\",\"player_saves\":\"\",\"player_inside_box_saves\":\"\",\"player_duels_total\":\"13\",\"player_duels_won\":\"7\",\"player_dribble_attempts\":\"3\",\"player_dribble_succ\":\"1\",\"player_pen_comm\":\"\",\"player_pen_won\":\"\",\"player_pen_scored\":\"0\",\"player_pen_missed\":\"0\",\"player_passes\":\"29\",\"player_passes_accuracy\":\"25\",\"player_key_passes\":\"2\",\"player_woordworks\":\"\",\"player_rating\":\"8.30\"}]}]}"


    
    
}

extension MockNetworkService : NetworkServicesProtocol{
    func fetchTeamsData(leagueId: Int, completion: @escaping (SportsApp.LeagueTeamsResponse?, Error?) -> Void) {
        do{
            let data = Data(fakeLeagueTeamsResponse.utf8)
            
          
            leagueTeamsResponse = try JSONDecoder().decode(LeagueTeamsResponse.self, from: data)
            completion(leagueTeamsResponse, nil)
        }catch{
            print(error.localizedDescription)
            completion(nil,error)
        }
    }
    
    func fetchTeamsDetails(teamId: Int, completion: @escaping (SportsApp.LeagueTeamsResponse?, Error?) -> Void) {
        do{
            let data = Data(fakeLeagueTeamsResponse.utf8)
            
          
            leagueTeamsResponse = try JSONDecoder().decode(LeagueTeamsResponse.self, from: data)
            completion(leagueTeamsResponse,nil)
        }catch{
            print(error.localizedDescription)
            completion(nil,error)
        }
    }
    
    func fetchLeaguesData(sportType: String, compilitionHandler: @escaping (SportsApp.Leagues?, Error?) -> Void) {
        do{
            let data = Data(fakeLeagueData.utf8)
            
          //  let data = try JSONSerialization.data(withJSONObject: fakeLeagueData)
            leagues = try JSONDecoder().decode(Leagues.self, from: data)
            compilitionHandler(leagues,nil)
        }catch{
            print(error.localizedDescription)
            compilitionHandler(nil,error)
        }
    }
    
    func fetchUpcomingData(sportType: String, leagueId: Int, compilitionHandler: @escaping (SportsApp.Events?, Error?) -> Void) {
        do{
            let data = Data(fakeUpcomingData.utf8)
            //var data = try JSONSerialization.data(withJSONObject: fakeLeagueData)
            upcoming = try JSONDecoder().decode(Events.self, from: data)
            compilitionHandler(upcoming,nil)
        }catch{
            print(error.localizedDescription)
            compilitionHandler(nil,error)
            
        }
    }
    
    func fetchLatestEvent(sportType: String, leagueId: Int, compilitionHandler: @escaping (SportsApp.Events?, Error?) -> Void) {
        do{
            let data = Data(fakeUpcomingData.utf8)
            //var data = try JSONSerialization.data(withJSONObject: fakeLeagueData)
            upcoming = try JSONDecoder().decode(Events.self, from: data)
            compilitionHandler(upcoming,nil)
        }catch{
            print(error.localizedDescription)
            compilitionHandler(nil,error)
            
        }
    }
    

   
}
