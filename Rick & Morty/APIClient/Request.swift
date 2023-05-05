//
//  Request.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 02.05.2023.
//

import Foundation

/// Object that represents a single API call
final class Request {

  // MARK: - Properties
  private struct Constants {
    static let baseURL = "https://rickandmortyapi.com/api"
  }
  private let endpoint: Endpoint
  private let pathComponents: [String]
  private let queryParameters: [URLQueryItem]
  /// Constructed URL for API request in string format
  private var urlString: String {
    var string = Constants.baseURL
    string += "/"
    string += endpoint.rawValue
    if !pathComponents.isEmpty {
      string += "/"
      pathComponents.forEach { string += "/\($0)" }
    }
    if !queryParameters.isEmpty {
      string += "?"
      let argumentString = queryParameters.compactMap {
        guard let value = $0.value else { return nil }
        return "\($0.name)=\(value)"
      }.joined(separator: "&")
      string += argumentString
    }
    return string
  }
  /// Makes URL from String
  public var url: URL? {
    return URL(string: urlString)
  }

  // MARK: - Init
  init(endpoint: Endpoint,
       pathComponents: [String] = [],
       queryParameters: [URLQueryItem] = []) {
    self.endpoint = endpoint
    self.pathComponents = pathComponents
    self.queryParameters = queryParameters
  }
}
