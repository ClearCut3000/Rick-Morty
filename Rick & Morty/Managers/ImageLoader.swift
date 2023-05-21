//
//  ImageLoader.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 22.05.2023.
//

import Foundation

final class ImageLoader {

  // MARK: - Properties
  static let shared = ImageLoader()
  private var imageDataCache = NSCache<NSString, NSData>()

  // MARK: Private Singleton Init
  private init() { }

  // MARK: - Methods
  /// Get image compent with URL and caching
  /// - Parameters:
  ///   - url: Source URL
  ///   - completion: callback
  public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    let key = url.absoluteString as NSString
    if let data = imageDataCache.object(forKey: key) {
      completion(.success(data as Data))
      return
    }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(error ?? URLError(.badServerResponse)))
        return
      }

      let value = data as NSData
      self?.imageDataCache.setObject(value, forKey: key)
      completion(.success(data))
    }
    task.resume()
  }
}
