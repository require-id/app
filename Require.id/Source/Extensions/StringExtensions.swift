// Require.id 2019

import Foundation

extension String {

    /// Returns localized string.
    func localized(comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }

}
