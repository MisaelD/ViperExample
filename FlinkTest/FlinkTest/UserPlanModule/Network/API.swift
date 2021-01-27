//
//  API.swift
//  FlinkTest
//
//  Created by Misael Delgado on 25/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation

class API {
    
    enum NetworkError: Error {
        case url
        case server
    }
    
    func makeAPICall() -> Result<String?, NetworkError> {
        let path = "https://us-central1-defatafit-4adcd.cloudfunctions.net/testFlink"
        guard let url = URL(string: path) else { return .failure(.url) }
        var result: Result<String?, NetworkError>!
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                result = .success(String(data: data, encoding: .utf8))
            } else {
                result = .failure(.server)
            }
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
}
