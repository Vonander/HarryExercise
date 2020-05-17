//
//  BookModels.swift
//  HarryExercise
//
//  Created by Johan Fornander on 2020-05-15.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import Foundation

struct ApiPayload: Codable {
    let nextPageToken: String
    let items: [Item]
}

struct Item: Codable {
    let title: String
    let authors: [Author]
    let narrators: [Narrator]
    let cover: CoverInfo
}

struct CoverInfo: Codable {
    let height: Int
    let width: Int
    let url: String
}

struct Author: Codable {
    let id: String
    let name: String
}

struct Narrator: Codable {
    let id: String
    let name: String
}
