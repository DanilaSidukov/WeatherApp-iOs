
protocol LocationRepositoryProtocol: GetCoordByGeoDelegate {
    
    func getLocationData(city: String) async throws -> LocationData
}
