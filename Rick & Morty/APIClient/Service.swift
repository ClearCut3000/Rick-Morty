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
    guard let urlRequest = self.request(from: request) else {
      completion(.failure(ServiceError.failedToCreateRequest))
      return
    }
    let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
      guard let data, error == nil else {
        completion(.failure(error ?? ServiceError.failedToGetData))
        return
      }
      do {
        let result = try JSONDecoder().decode(type.self, from: data)
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
