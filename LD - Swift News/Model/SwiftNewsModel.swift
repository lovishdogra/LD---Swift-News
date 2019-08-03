//
//  SwiftNewsModel.swift
//  LD - Swift News
//
//  Created by Lovish Dogra on 2019-08-03.
//  Copyright © 2019 Lovish Dogra. All rights reserved.
//

import Foundation

struct SwiftNewsModel: Codable {
    var data: ChildrenProp?
}

struct ChildrenProp: Codable {
    var dist: Int?
    var children: [DataProp]?
    var after: String?
}

struct DataProp: Codable {
    var data: SwiftNewsProp?
}

struct SwiftNewsProp: Codable {
    var selftext: String?
    var title: String?
    var thumbnail: String?
}
