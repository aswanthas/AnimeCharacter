//
//  ApiEndPoint.swift
//  AnimeCharacter
//
//  Created by Aswanth K on 01/07/24.
//

public enum AnimeAPI {
    case characterList(page: Int)
    case characterDetails(id: Int)
    // Add more cases as needed

    // Base URL for the API
    private var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }

    // Full URL string for each API case
    public var urlString: String {
        switch self {
        case .characterList(let page):
            return "\(baseURL)/character/?page=\(page)"
        case .characterDetails(let id):
            return "\(baseURL)/character/\(id)"
        }
    }
}
