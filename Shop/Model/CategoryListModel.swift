//
//  CategoryListModel.swift
//  Shop
//
//  Created by macexpert on 10/05/21.
//

import Foundation

//MARK: - Categories

struct CategoryListModel : Codable {
    let objects : [Objects]?
    let next : String?

    enum CodingKeys: String, CodingKey {

        case objects = "objects"
        case next = "next"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        objects = try values.decodeIfPresent([Objects].self, forKey: .objects)
        next = try values.decodeIfPresent(String.self, forKey: .next)
    }

}

//MARK: - Objects
struct Objects : Codable {
    let category : String?
    let title : String?
    let weight : Double?
    let size : Size?

    enum CodingKeys: String, CodingKey {

        case category = "category"
        case title = "title"
        case weight = "weight"
        case size = "size"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        weight = try values.decodeIfPresent(Double.self, forKey: .weight)
        size = try values.decodeIfPresent(Size.self, forKey: .size)
    }

}

//MARK: - Size
struct Size : Codable {
    let width : Double?
    let length : Double?
    let height : Double?

    enum CodingKeys: String, CodingKey {

        case width = "width"
        case length = "length"
        case height = "height"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        width = try values.decodeIfPresent(Double.self, forKey: .width)
        length = try values.decodeIfPresent(Double.self, forKey: .length)
        height = try values.decodeIfPresent(Double.self, forKey: .height)
    }

}
