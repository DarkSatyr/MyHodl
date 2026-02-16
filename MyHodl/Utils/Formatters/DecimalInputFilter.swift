//
//  DecimalInputFilter.swift
//  MyHodl
//
//  Created by DarkSatyr on 16.02.2026.
//

import Foundation

struct DecimalInputFilter {
    static func limit(
        _ raw: String,
        sep: Character,
        maxFractionDigits: Int
    ) -> String {

        let filtered = raw.filter { $0.isNumber || sep == $0 }
        if let firstSep = filtered.firstIndex(of: sep) {
            let before = filtered[..<firstSep]
            let afterStart = filtered.index(after: firstSep)
            var after = filtered[afterStart...].replacingOccurrences(of: String(sep), with: "")
            if after.count > maxFractionDigits {
                after = String(after.prefix(maxFractionDigits))
            }
            return String(before) + String(sep) + after
        }
        return filtered
    }
}
