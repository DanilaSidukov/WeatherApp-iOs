

struct LocationRepository: LocationRepositoryProtocol {    
    
    let getCoordByGeo: GetCoordByGeoUseCase
    
    init(getCoordByGeoUseCase: GetCoordByGeoUseCase) {
        self.getCoordByGeo = getCoordByGeoUseCase
    }
    
    func getLocationData(city: String) async throws -> GeocodingData {
        let data = try await getCoordByGeo.invoke(city: city)
        return data
    }
}
