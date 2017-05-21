//
//  DateExtensionMilliseconds.swift
//  MarvelHeroes
//
//  Created by Aina Cuxart on 22/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
