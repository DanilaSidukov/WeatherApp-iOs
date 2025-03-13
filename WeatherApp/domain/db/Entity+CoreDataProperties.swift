//
//  Entity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Danila Sidukov on 13.03.2025.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Location")
    }

    @NSManaged public var isSelected: Bool
    @NSManaged public var location: String?
    @NSManaged public var temperature: String?
    @NSManaged public var temperatureRange: String?
    @NSManaged public var weatherIcon: String?

}

extension Entity : Identifiable {

}
