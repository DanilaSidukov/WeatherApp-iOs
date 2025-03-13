//
//  Entity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Danila Sidukov on 13.03.2025.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var isSelected: Bool
    @NSManaged public var location: String?
    @NSManaged public var temperature: String?
    @NSManaged public var temperatureRange: String?
    @NSManaged public var weatherIcon: String?

}

extension Location : Identifiable {

}
