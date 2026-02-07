//
//  String+Hodl.swift
//  MyHodl
//
//  Created by DarkSatyr on 05.02.2026.
//

import Foundation

extension String {
    func trimmed() -> String { trimmingCharacters(in: .whitespacesAndNewlines) }
    func normalize() -> String { trimmed().uppercased() }
}
