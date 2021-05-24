//
//  Array+Only.swift
//  Memorize
//
//  Created by Jonas Müller on 27.05.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first  : nil
    }
}
