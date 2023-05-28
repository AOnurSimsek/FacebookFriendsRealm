//
//  LocationResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct LocationResponseModel: Codable {
    let street: StreetResponseModel?
    let city: String?
    let state: String?
    let country: String?
    let postcode: String?
    let coordinates: CoordinateResponseModel?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decodeIfPresent(StreetResponseModel.self, forKey: .street)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        do {
            self.postcode = try container.decodeIfPresent(String.self, forKey: .postcode)
        } catch DecodingError.typeMismatch {
            self.postcode = try String(container.decodeIfPresent(Int.self, forKey: .postcode) ?? -1)
        }
        self.coordinates = try container.decodeIfPresent(CoordinateResponseModel.self, forKey: .coordinates)
    }
}
