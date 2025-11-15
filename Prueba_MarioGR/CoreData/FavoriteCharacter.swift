//
//  FavoriteCharacter.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//
import Foundation
import CoreData

@objc(FavoriteCharacter)
public class FavoriteCharacter: NSManagedObject {
}

extension FavoriteCharacter {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCharacter> {
        return NSFetchRequest<FavoriteCharacter>(entityName: "FavoriteCharacter")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var image: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var createdAt: Date?
}
