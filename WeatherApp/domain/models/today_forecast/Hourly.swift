
struct Hourly: Codable{
    
    let rain: [Float]
    let snowfall: [Float]
    let cloudcoverMid: [Float]
    // Temperature
    let temperature2m: [Float]
    // Humidity
    let relativehumidity2m: [Float]
    let time: [String]
    let weathercode: [Int]
    let precipitation: [Float]
}
