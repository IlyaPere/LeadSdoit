//
//  KeyValueStorage.swift
//  LeadSdoit
//
//  Created by Илья Петров on 02.01.2023.
//

import Foundation

public protocol KeyValueStorage {

    // MARK: - Instance Methods

    func keyValue<T: Codable>(of type: T.Type, forKey: String) -> T?
    func setKeyValue<T: Codable>(_ value: T?, forKey: String)
}

// MARK: - Default Implementation

extension KeyValueStorage {

    // MARK: - Instance Methods

    public func makeKeyValueContainer<T>(
        of type: T.Type = T.self,
        key: String = #function
    ) -> KeyValueContainer<T> {
        KeyValueContainer(storage: self, key: key)
    }

    public func keyValue<T: Codable>(forKey key: String) -> T? {
        keyValue(of: T.self, forKey: key)
    }
}

// MARK: - KeyValueStorage

extension UserDefaults: KeyValueStorage {

    // MARK: - Instance Methods

    public func keyValue<T: Codable>(of type: T.Type, forKey key: String) -> T? {
        guard object(forKey: key) != nil else {
            return nil
        }

        switch T.self {
        case is Bool.Type:
            return bool(forKey: key) as? T

        case is Int.Type:
            return integer(forKey: key) as? T

        case is Float.Type:
            return float(forKey: key) as? T

        case is Double.Type:
            return double(forKey: key) as? T

        case is Date.Type:
            return object(forKey: key) as? T

        case is String.Type:
            return string(forKey: key) as? T

        case is Data.Type:
            return data(forKey: key) as? T

        case is URL.Type:
            return url(forKey: key) as? T

        case is [String].Type:
            return stringArray(forKey: key) as? T

        default:
            guard let data = data(forKey: key) else { return nil }

            let decoder = JSONDecoder()
            return (try? decoder.decode([T].self, from: data))?.first
        }
    }

    public func setKeyValue<T: Codable>(_ value: T?, forKey key: String) {
        switch value {
        case let bool as Bool where T.self is Bool.Type:
            set(bool, forKey: key)

        case let integer as Int where T.self is Int.Type:
            set(integer, forKey: key)

        case let float as Float where T.self is Float.Type:
            set(float, forKey: key)

        case let double as Double where T.self is Double.Type:
            set(double, forKey: key)

        case let date as Date where T.self is Date.Type:
            set(date, forKey: key)

        case let string as String where T.self is String.Type:
            set(string, forKey: key)

        case let data as Data where T.self is Data.Type:
            set(data, forKey: key)

        case let url as URL where T.self is URL.Type:
            set(url, forKey: key)

        case let stringArray as [String] where T.self is [String].Type:
            set(stringArray, forKey: key)

        default:
            let encoder = JSONEncoder()

            guard let data = value.flatMap({ try? encoder.encode([$0]) }) else {
                removeObject(forKey: key)
                return
            }

            set(data, forKey: key)
        }
    }
}

