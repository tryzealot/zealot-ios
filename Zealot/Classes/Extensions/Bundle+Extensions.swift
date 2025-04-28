//
//  Bundle+Extensions.swift
//  Zealot
//
//  Created by Brovko Roman on 14.03.2025.
//

import Foundation

extension Bundle {
    final class func localizedString(forKey key: String) -> String {
        guard var path = zealotBundlePath() else {
            return key
        }

        return Bundle(path: path)?.localizedString(forKey: key, value: key, table: nil) ?? key
    }
    
    /// Constants used in the `Bundle` extension.
    struct Constants {
        /// Constant for the `.bundle` file extension.
        static let bundleExtension = "bundle"
    }
}

private extension Bundle {
    /// The path to Zealot's localization `Bundle`.
    ///
    /// - Returns: The bundle's path or `nil`.
    final class func zealotBundlePath() -> String? {
#if SWIFT_PACKAGE
        return Bundle.module.path(forResource: "\(Zealot.self)", ofType: Constants.bundleExtension)
#else
        return Bundle(for: Zealot.self).path(forResource: "\(Zealot.self)", ofType: Constants.bundleExtension)
#endif
    }
}
