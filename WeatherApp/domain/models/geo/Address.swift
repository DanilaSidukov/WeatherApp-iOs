
struct Address: Codable {
    
    let country: String?
    let countryCode: String?
    let countryCodeISO3: String?
    // District
    let countrySecondarySubdivision: String?
    let countrySubdivision: String?
    // TeritaryDistrict
    let countryTertiarySubdivision: String?
    let freeformAddress: String?
    let localName: String?
    // City
    let municipality: String?
    let postalCode: String?
    let streetName: String?
    // Town
    let municipalitySubdivision: String?
}
