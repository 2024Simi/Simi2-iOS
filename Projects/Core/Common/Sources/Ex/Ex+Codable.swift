//
//  servicedumy.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import UIKit

public extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        return dictionary as? [String: Any] ?? [:]
    }
}

public extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
