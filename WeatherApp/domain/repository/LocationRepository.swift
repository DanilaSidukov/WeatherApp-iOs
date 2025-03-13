import Foundation
import OSLog

class LocationRepository {
    
    private let logger = Logger(subsystem: "com.diphrogram.weatherapp", category: "LocationRepository")
    
    static let shared = LocationRepository()
}

extension LocationRepository: LocationRepositoryProtocol {
    
    func getLocationData(city: String) async throws -> LocationData {
        
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        
        // DOC for GEOCODING - https://developer.tomtom.com/geocoding-api/documentation/geocode
        // url example = https://api.tomtom.com/search/2/geocode/%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0.json?view=Unified&key=sHOgdqa34WjcDtweEdBGyhe9FA4WzL1i
        let endpoint = "\(API.GEO)/search/2/geocode/\(encodedCity).json?view=Unified&key=sHOgdqa34WjcDtweEdBGyhe9FA4WzL1i"
        
        guard let url = URL(string: endpoint) else {
            logger.error("invalidURL")
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == NetworkCode.success else {
            logger.error("invalidResponse: \((response as? HTTPURLResponse))")
            throw NetworkError.invalidResponse
        }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(GeocodingData.self, from: data)
                guard let result = decodedData.results?.first else {
                    logger.error("invalidData in result")
                    throw NetworkError.invalidData
                }
                let locationData = LocationData(
                    location: result.address?.municipality,
                    temperature: "2",
                    temperatureRange: "4",
                    weatherIcon: "ic_cloud_black_with_sun"
                )
                return locationData
            } catch {
                logger.error("invalidData catched \(error)")
                throw NetworkError.invalidData
            }
        }
    }
