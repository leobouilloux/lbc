//
//  MockProvider.swift
//  LBC
//
//  Created by Leo Marcotte on 30/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

enum MockProviderConfig {
    case success
    case generateError(ofType: MockError)
}

class MockProvider: Provider {
    private let config: MockProviderConfig

    init(config: MockProviderConfig) {
        self.config = config
    }

    func fetchData(completion: @escaping (Result<[Item], Error>) -> Void) {
        switch self.config {
        case let .generateError(ofType: error):
            completion(.failure(error))
        case .success:
            if let path = Bundle(for: MockProvider.self).path(forResource: "listing", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    do {
                        let items = try decoder.decode([Item].self, from: data)
                        completion(.success(items))
                    } catch {
                        completion(.failure(MockError.deserializationFailed))
                    }
                } catch {
                    completion(.failure(MockError.cannotReadFile))
                }
            }
        }
    }
}
