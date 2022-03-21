//
//  Music.swift
//  SampleiTunesAPI
//
//  Created by Makoto on 2022/03/20.
//

import Foundation

struct Response: Codable {
    
    let resultCount: Int
    let results: [Music]
    
    struct Music: Codable {
        
        let artistName: String
        let trackCensoredName: String
        let previewUrl: String
        let artworkUrl100: String
    }
}
