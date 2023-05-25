//
//  LocationResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct LocationResponseModel: Decodable {
    let street: StreetResponseModel?
    let city: String?
    let state: String?
    let country: String?
    let postcode: String?
    let coordinates: CoordinateResponseModel?
    let timezone: TimezoneResponseModel?
    
    //Added because of postcode. It can be String or Int according to country
    enum CodingKeys: CodingKey {
        case street
        case city
        case state
        case country
        case postcode
        case coordinates
        case timezone
    }
    
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
        self.timezone = try container.decodeIfPresent(TimezoneResponseModel.self, forKey: .timezone)
    }
}
