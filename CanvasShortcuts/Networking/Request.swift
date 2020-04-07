//
//  Request.swift
//  CanvasShortcuts
//
//  Created by Cory Swainston on 4/7/20.
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Foundation

func getFromCanvas(endpoint: String, params: [String: String] = [:], completion: @escaping (Any) -> Void) {
    let accessToken = UserDefaults.standard.string(forKey: "access_token")
    let queryStringElements = params.map { (key: String, value: String) -> String in
        return "\(key)=\(value)"
    }
    let queryString = queryStringElements.joined(separator: "&")
    let url = URL(string: "http://127.0.0.1:8888/\(endpoint)?access_token=\(accessToken!)&\(queryString)")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        completion(json!)
    }
    task.resume()
}
