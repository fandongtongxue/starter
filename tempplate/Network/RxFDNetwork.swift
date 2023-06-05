//
//  RxFDNetwork.swift
//  RxProject
//
//  Created by isoftstone on 2023/5/19.
//

import Foundation
import Alamofire
import FDLibrary

extension RxFDNetwork {
    static func getRequest(method: Alamofire.HTTPMethod = .post,
                           url: String,
                           parameters: [String: Any]? = nil) -> FDRequest {
        FDRequest(method: method, url: url, parameters: parameters, encoding: JSONEncoding.default, headers: [
            "Content-Type" : "application/json",
        ])
    }
    static func getRequestGet(url: String,
                              parameters: [String: Any]? = nil) -> FDRequest {
        FDRequest(method: .get, url: url, parameters: parameters, headers: [:
        ])
    }
}
