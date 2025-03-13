import Foundation
import UIKit
import CoreData

final class WeatherCoreDataService {

    static let shared = WeatherCoreDataService()
    
    var locations: [Location] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "WeatherModel")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getAllLocations() {
        let request = Location.fetchRequest()
        if let locations = try? context.fetch(request) {
            self.locations = locations
        }
    }
    
    func addLocation(locationData: LocationData) {
        let location = Location(context: context)
        location.location = locationData.location
        location.isSelected = true
        location.temperature = locationData.temperature
        location.temperatureRange = locationData.temperatureRange
        location.weatherIcon = locationData.weatherIcon
        
        saveContext()
        getAllLocations()
    }
}

extension Location {
    
    func convertToLocationItemView() -> LocationItemView {
        return LocationItemView(
            location: self.location ?? String.empty,
            isSelected: self.isSelected,
            temperature: self.temperature ?? String.empty,
            temperatureRange: self.temperatureRange ?? String.empty,
            weatherIcon: UIImage(named: self.weatherIcon ?? "ic_cloud_black_with_sun")!
        )
    }
}
