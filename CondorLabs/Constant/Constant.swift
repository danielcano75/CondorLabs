//
//  Constant.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation

// MARK: Base Server Url Development
fileprivate let defBase = URL(string: "https://pokeapi.co/api/v2")!
fileprivate let defApi  = APIClient()

struct Constant {
    let Base : URL
    let Api  : APIClient
    
    static let `default` = Constant(Base: defBase,
                                    Api: defApi)
}
