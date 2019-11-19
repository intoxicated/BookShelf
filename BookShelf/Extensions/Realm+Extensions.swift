//
//  Realm+Extensions.swift
//  BookShelf
//
//  Created by R3alFr3e on 11/17/19.
//  Copyright © 2019 intoxicated. All rights reserved.
//

import RealmSwift

enum RealmError: Error {
  case realmAccess
  case realmWrite
}

extension Realm {
  static func safeInit() throws -> Realm? {
    do {
      let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
      let realm = try Realm(configuration: configuration)
      return realm
    } catch {
      throw RealmError.realmAccess
    }
  }

  public func safeWrite(_ block: () -> Void) throws {
    do {
      if !isInWriteTransaction {
        try write(block)
      }
    } catch {
      throw RealmError.realmWrite
    }
  }
}
