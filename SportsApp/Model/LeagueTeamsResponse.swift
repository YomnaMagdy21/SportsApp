import Foundation

// MARK: - Welcome1
struct LeagueTeamsResponse: Codable {
    let success: Int
    let result: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
    let coaches: [Coach]?
}

// MARK: - Coach
struct Coach: Codable {
    let coach_name: String?
    let coach_country: String?
    let coachAge: String?
}

// MARK: - Player
struct Player: Codable {
    let playerKey: Int?
    let player_image: String?
    let player_name: String?
    let playerNumber: String?
    let playerCountry: String?
    let playerType: PlayerType?
    let playerAge: String?
    let playerMatchPlayed: String?
    let playerGoals: String?
    let playerYellowCards: String?
    let playerRedCards: String?
    let playerInjured: PlayerInjured?
    let playerSubstituteOut: String?
    let playerSubstitutesOnBench: String?
    let playerAssists: String?
    let playerBirthdate: String?
    let playerIsCaptain: String?
    let playerShotsTotal: String?
    let playerGoalsConceded: String?
    let playerFoulsCommitted: String?
    let playerTackles: String?
    let playerBlocks: String?
    let playerCrossesTotal: String?
    let playerInterceptions: String?
    let playerClearances: String?
    let playerDispossesed: String?
    let playerSaves: String?
    let playerInsideBoxSaves: String?
    let playerDuelsTotal: String?
    let playerDuelsWon: String?
    let playerDribbleAttempts: String?
    let playerDribbleSucc: String?
    let playerPenComm: String?
    let playerPenWon: String?
    let playerPenScored: String?
    let playerPenMissed: String?
    let playerPasses: String?
    let playerPassesAccuracy: String?
    let playerKeyPasses: String?
    let playerWoordworks: String?
    let playerRating: String?

    enum PlayerInjured: String, Codable {
        case no = "No"
        case yes = "Yes"
    }
    
    enum PlayerType: String, Codable {
        case defenders
        case forwards
        case goalkeepers
        case midfielders
    }
}
