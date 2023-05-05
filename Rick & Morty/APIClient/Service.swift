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
  /// Private singleton init
  private init() { }
  
  // MARK: - Methods

  /// Send API Call
  /// - Parameters:
  ///   - request: Request instance
  ///   - completion: Callback with data of error
  public func execute(_ request: Request, completion: @escaping (Result<String, Error>) -> Void ) {

  }
}
