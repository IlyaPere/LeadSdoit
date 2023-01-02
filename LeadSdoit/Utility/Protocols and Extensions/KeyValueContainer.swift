//
//  KeyValueContainer.swift
//  LeadSdoit
//
//  Created by Илья Петров on 02.01.2023.
//

import Foundation

public class KeyValueContainer<Value: Codable> {

    // MARK: - Instance Properties

    public let storage: KeyValueStorage
    public let key: String

    public var value: Value? {
        get { storage.keyValue(forKey: key) }
        set { storage.setKeyValue(newValue, forKey: key) }
    }

    public var hasValue: Bool { value != nil }

    // MARK: - Initializers

    public init(storage: KeyValueStorage, key: String) {
        self.storage = storage
        self.key = key
    }
}
