
struct Result: Codable {
    let address: Address?
    let entityType: String?
    let id: String?
    let position: Position?
    let score: Float?
    let resultType: String? // Изменил с "type", чтобы избежать конфликтов
    
    enum CodingKeys: String, CodingKey {
        case address, entityType, id, position, score
        case resultType = "type"
    }
}
