//
//  Collection.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import Foundation

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
