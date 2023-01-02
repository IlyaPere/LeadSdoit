//
//  UserDefaultsStorage.swift
//  LeadSdoit
//
//  Created by Илья Петров on 02.01.2023.
//

import Foundation

extension UserDefaults {
    
    var bankBalance: KeyValueContainer<Int> { makeKeyValueContainer() }

}
