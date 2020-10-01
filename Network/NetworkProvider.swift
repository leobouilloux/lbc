//
//  NetworkProvider.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

class NetworkProvider: Provider {
    func fetchData(completion: @escaping (Result<[Item], Error>) -> Void) {
        let session = URLSession.shared
        session.configuration.urlCache = nil
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else { return }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30.0)

        let task = session.dataTask(with: request, completionHandler: { data, _, error in
            if error != nil {
                completion(.failure(NetworkError.errorReceived))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let items = try decoder.decode([Item].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(NetworkError.jsonDecodeFailed))
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            } else {
                    completion(.failure(NetworkError.noDataReceived))
            }
        })
        task.resume()
    }
}
