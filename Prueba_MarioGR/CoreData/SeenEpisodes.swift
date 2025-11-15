//
//  SeenEpisodes.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation
import CoreData

@objc(SeenEpisodes)
public class SeenEpisodes: NSManagedObject {
}

extension SeenEpisodes {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeenEpisodes> {
        return NSFetchRequest<SeenEpisodes>(entityName: "SeenEpisodes")
    }

    @NSManaged public var urlString: String
}
