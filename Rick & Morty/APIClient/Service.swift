//
//  Service.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 02.05.2023.
//

import Foundation

/// Primary API service object to get data
final class Service {
  /// Shared singleton
  static let shared = Service()

  private let cacheManager = CacheManager()
  /// Errors
  enum ServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
  }
  /// Private singleton init
  private init() { }
  
  // MARK: - Methods
  /// Send API Call
  /// - Parameters:
  ///   - request: Request instance
  ///   - type: The type of object expected to be returned
  ///   - completion: Callback with data or error
  public func execute<T: Codable>(_ request: Request,
                                  expecting type: T.Type,
                                  completion: @escaping (Result<T, Error>) -> Void ) {
    if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url) {
      do {
        let result = try JSONDecoder().decode(type.self, from: cachedData)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
      return
    }
    guard let urlRequest = self.request(from: request) else {
      completion(.failure(ServiceError.failedToCreateRequest))
      return
    }
    let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
      guard let data, error == nil else {
        completion(.failure(error ?? ServiceError.failedToGetData))
        return
      }
      do {
        let result = try JSONDecoder().decode(type.self, from: data)
        self?.cacheManager.setCache(for: request.endpoint,
                                    url: request.url,
                                    data: data)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }

  private func request(from rmRequest: Request) -> URLRequest? {
    guard let url = rmRequest.url else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = rmRequest.httpMethod
    return request
  }
}
