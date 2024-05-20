import Foundation

// MARK: - Welcome1
struct LeagueTeamsResponse: Decodable {
    let success: Int
    let result: [Result]?
}

// MARK: - Result
struct Result: Decodable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?
    let coaches: [Coach]?
}

// MARK: - Coach
struct Coach: Decodable {
    let coachName: String?
    let coachCountry: String?
    let coachAge: String?
}

// MARK: - Player
struct Player: Decodable {
    let playerKey: Int?
    let playerImage: String?
    let playerName: String?
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

    enum PlayerInjured: String, Decodable {
        case no = "No"
        case yes = "Yes"
    }
    
    enum PlayerType: String, Decodable {
        case defenders
        case forwards
        case goalkeepers
        case midfielders
    }
}
