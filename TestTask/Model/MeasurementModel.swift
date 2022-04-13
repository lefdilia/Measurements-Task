//
//  MeasurementModel.swift
//  TestTask
//
//  Created by Lefdili Alaoui Ayoub on 12/4/2022.
//

import Foundation

struct MeasurementModel: Codable {
    let name: String
    let measurements: [[Measurement]]
    let id: String
    let unit: String?

    enum CodingKeys: String, CodingKey {
        case name, measurements
        case id = "_id"
        case unit
    }
}

enum Measurement: Codable {
    
    case double(Double)
    case doubleArray([Double])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let measure = try? container.decode([Double].self) {
            self = .doubleArray(measure)
            return
        }
        if let measure = try? container.decode(Double.self) {
            self = .double(measure)
            return
        }
        if let measure = try? container.decode(String.self) {
            self = .string(measure)
            return
        }
        
        throw DecodingError.typeMismatch(Measurement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Measurement"))
    }
    
    var name: Any {
        switch self {
        case .double(let measure): return measure as Double
        case .doubleArray(let measure): return measure as [Double]
        case .string(let measure): return measure as String
        }
    }

}


