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
  /// API Constants
  private struct Constants {
    static let baseURL = "https://rickandmortyapi.com/api"
  }
  /// Desired Endpoint
  let endpoint: Endpoint
  /// Path Components for API if any
  private let pathComponents: [String]
  /// Query Components for API if anny
  private let queryParameters: [URLQueryItem]
  /// Constructed URL for API request in string format
  private var urlString: String {
    var string = Constants.baseURL
    string += "/"
    string += endpoint.rawValue
    if !pathComponents.isEmpty {
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
  /// Deesired http method
  public let httpMethod = "GET"

  // MARK: - Init
  /// Construct request
  /// - Parameters:
  ///   - endpoint: target endpoint
  ///   - pathComponents: colllection of path components
  ///   - queryParameters: cillection query parameters
  init(endpoint: Endpoint,
       pathComponents: [String] = [],
       queryParameters: [URLQueryItem] = []) {
    self.endpoint = endpoint
    self.pathComponents = pathComponents
    self.queryParameters = queryParameters
  }

  /// Attempt to create request
  /// - Parameter url: URL to parse
  convenience init?(url: URL) {
    let string = url.absoluteString
    if !string.contains(Constants.baseURL) {
      return nil
    }
    let trimmed = string.replacingOccurrences(of: Constants.baseURL + "/", with: "")
    if trimmed.contains("/") {
      let components = trimmed.components(separatedBy: "/")
      if !components.isEmpty {
        let endpointString = components[0]
        var pathComponents: [String] = []
        if components.count > 1 {
          pathComponents = components
          pathComponents.removeFirst()
        }
        if let endpoint = Endpoint(rawValue: endpointString) {
          self.init(endpoint: endpoint, pathComponents: pathComponents)
          return
        }
      }
    } else if trimmed.contains("?") {
      let components = trimmed.components(separatedBy: "?")
      if !components.isEmpty, components.count >= 2 {
        let endpointString = components[0]
        let queryItemsString = components[1]
        let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap {
          guard $0.contains("=") else { return nil }
          let parts = $0.components(separatedBy: "=")
          return URLQueryItem(name: parts[0], value: parts[1])
        }
        if let endpoint = Endpoint(rawValue: endpointString) {
          self.init(endpoint: endpoint, queryParameters: queryItems)
          return
        }
      }
    }
    return nil
  }
}

// MARK: - Extension
extension Request {
  static let listCharactersRequest = Request(endpoint: .character)
  static let listEpisodesRequest = Request(endpoint: .episode)
  static let listLocationsRequest = Request(endpoint: .location)
}

