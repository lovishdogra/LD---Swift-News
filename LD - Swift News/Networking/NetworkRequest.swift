//
//  NetworkRequest.swift
//  LD - Swift News
//
//  Created by Lovish Dogra on 2019-08-03.
//  Copyright © 2019 Lovish Dogra. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

enum StringURL: String {
    
    case baseURL = "https://www.reddit.com/"
    
    static func requestSwiftNews() -> String {
        return StringURL.baseURL.rawValue + "r/swift.json"
    }
    
}

struct NetworkRequest {
    
    func getSwiftNews(completion: @escaping (SwiftNewsModel?, Error?) -> ()) {
        
        guard let resourceURL = URL(string: StringURL.requestSwiftNews()) else {fatalError()}
        
        Alamofire.request(resourceURL).responseJSON { (response) in
            if response.value != nil {
                if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                    let decoder = JSONDecoder()
                    do {
                        let swiftNewsData = try decoder.decode(SwiftNewsModel.self, from: data)
                        completion(swiftNewsData, nil)
                    } catch let jsonError{
                        completion(nil, jsonError)
                    }
                }
            } else {
                print("Nil response")
            }
        }
    }
}
