//
//  ImageModelClass.swift
//  MaheshBabu-24Dec
//
//  Created by Mahesh babu on 24/12/23.
//

import Foundation


struct ImageModelClass: Codable {
    let status: Int
    let data: [ImageData]
}

struct ImageData: Codable {
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
}
