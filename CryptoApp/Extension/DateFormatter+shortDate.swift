//
//  DateFormatter+shortDate.swift
//  CryptoApp
//
//  Created by Nikita Gras on 24.05.2021.
//

import Foundation

extension DateFormatter {
    static var shortDate: DateFormatter {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.setLocalizedDateFormatFromTemplate("MMM d, YYYY h:mm a")
        return df
    }
}
