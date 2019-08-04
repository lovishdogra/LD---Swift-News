//
//  SwiftNewsModel.swift
//  LD - Swift News
//
//  Created by Lovish Dogra on 2019-08-03.
//  Copyright © 2019 Lovish Dogra. All rights reserved.
//

import Foundation

struct SwiftNewsModel: Codable {
    var data: ChildrenPropModel?
}

struct ChildrenPropModel: Codable {
    var dist: Int?
    var children: [DataPropModel]?
    var after: String?
}

struct DataPropModel: Codable {
    var data: SwiftNewsPropModel?
}

struct SwiftNewsPropModel: Codable {
    var selftext: String?
    var title: String?
    var thumbnail: String?
}
