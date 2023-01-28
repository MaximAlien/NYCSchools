//
//  Cache.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 27.01.2023.
//

import Foundation

protocol Caching {
    
    func object(for key: String) -> AnyObject?
    
    func setObject(_ object: AnyObject, for key: String)
    
    func removeObject(for key: String)
}

/// Cache that allows to temporarily store transient key-value pairs that are subject
/// to eviction when resources are low.
class Cache: Caching {
    
    static let shared = Cache()
    
    let cache = NSCache<NSString, AnyObject>()
    
    /// Returns the value associated with a given key.
    /// - Parameter key: An object identifying the value.
    /// - Returns: The value associated with key, or nil if no value is associated with key.
    func object(for key: String) -> AnyObject? {
        cache.object(forKey: key as NSString)
    }
    
    /// Sets the value of the specified key in the cache.
    /// - Parameters:
    ///   - object: The object to be stored in the cache.
    ///   - key: The key with which to associate the value.
    func setObject(_ object: AnyObject, for key: String) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    /// Removes the value of the specified key in the cache.
    /// - Parameter key: The key identifying the value to be removed.
    func removeObject(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    /// Empties the cache.
    func removeAllObjects() {
        cache.removeAllObjects()
    }
}
