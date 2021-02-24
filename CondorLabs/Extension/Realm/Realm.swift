//
//  Realm.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 24/02/21.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> ())) throws {
        do {
            if isInWriteTransaction {
                try block()
            } else {
                try write(block)
            }
        } catch {
            print("Erorr al Agregar Mensage")
        }
        
    }
    
    func deleteAll<T: Object>(_ data: [T.Type]) {
        let realm = try! Realm()
        realm.refresh()
        try? realm.safeWrite {
            for object in data {
                let allObjects = realm.objects(object)
                realm.delete(allObjects)
            }
        }
    }
}
