//
//  NetworkProvider.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case jsonDecodeFailed
    case errorReceived
    case noDataReceived
}

class NetworkProvider: Provider {
    func fetchData(completion: @escaping (Result<[Item], NetworkError>) -> ()) {
        let session = URLSession.shared
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else { return }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check the response
            if let error = error {
                completion(.failure(.errorReceived))
                print(error)
                return
            } else if let data = data {
                // Serialize the data into an object
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let items = try decoder.decode([Item].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(.jsonDecodeFailed))
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            } else {
                    completion(.failure(.noDataReceived))
            }
        })
        task.resume()
    }
}
