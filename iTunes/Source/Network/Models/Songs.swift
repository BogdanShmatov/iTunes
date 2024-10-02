//
//  Songs.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 02.10.2024.
//

import Foundation

// MARK: - Songs
struct Songs: Codable {
    let resultCount: Int
    let results: [Song]
}

// MARK: - Result
struct Song: Codable {
    let artistID, collectionID: Int?
    let trackID: Int?
    let artistName, collectionName, trackName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl100: String?
    let trackTimeMillis: Int?
    let primaryGenreName: String?

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl100, trackTimeMillis, primaryGenreName
    }
}
