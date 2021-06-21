//
//  Planet.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import Foundation

// MARK: - Welcome
struct PlanetData: Codable {
    var count: Int?
    var next: String?
    var previous: JSONNull?
    var results: [PlanetDataResult]?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
}

// MARK: - Result
struct PlanetDataResult: Codable {
    var name: String?
    var rotationPeriod: String?
    var orbitalPeriod: String?
    var diameter: String?
    var climate: String?
    var gravity: String?
    var terrain: String?
    var surfaceWater: String?
    var population: String?
    var residents: [String]?
    var films: [String]?
    var created: String?
    var edited: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surfaceWater = "surface_water"
        case population = "population"
        case residents = "residents"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
