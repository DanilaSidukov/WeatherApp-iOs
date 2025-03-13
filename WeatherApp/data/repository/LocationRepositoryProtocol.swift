
protocol LocationRepositoryProtocol {
    
    func getLocationData(city: String) async throws -> GeocodingData
}
