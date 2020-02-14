//
//  String+Ext.swift
//  Project Fueler
//
//  Created by Murat Baykor on 13.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation

extension String {
    func localized(with comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
