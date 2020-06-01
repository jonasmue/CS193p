//
//  Int+Dividable.swift
//  Memorize
//
//  Created by Jonas Müller on 01.06.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import Foundation

extension Int {
    
    func isSquare() -> Bool {
        round(pow((Double(self)),(0.5))) == pow((Double(self)),(0.5))
    }
}
