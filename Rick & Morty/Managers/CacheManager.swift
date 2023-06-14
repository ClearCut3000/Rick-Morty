//
//  CacheManager.swift
//  Rick & Morty
//
//  Created by Николай Никитин on 14.06.2023.
//

import Foundation

/// Manages in memory session scoped API caches
final class CacheManager {

  // MARK: - Properties
  private var cacheDictionary: [Endpoint: NSCache<NSString, NSData>] = [:]

  // MARK: - Init
  init() {
    setupCache()
  }

  // MARK: - Methods
  public func cachedResponse(for endpoint: Endpoint, url: URL?) -> Data? {
    guard let targetCache = cacheDictionary[endpoint],
          let url = url else {
      return nil
    }
    let key = url.absoluteString as NSString
    return targetCache.object(forKey: key) as? Data
  }

  public func setCache(for endpoint: Endpoint, url: URL?, data: Data) {
    guard let targetCache = cacheDictionary[endpoint],
          let url = url else {
      return
    }
    let key = url.absoluteString as NSString
    targetCache.setObject(data as NSData, forKey: key)
  }

  private func setupCache() {
    Endpoint.allCases.forEach { endpoint in
      cacheDictionary[endpoint] = NSCache<NSString, NSData>()
    }
  }

}
