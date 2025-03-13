
struct TodayForecastBody: Codable{
    
    let currentWeather: CurrentWeather
    let hourly: Hourly
    let hourlyUnits: HourlyUnits
    let latitude: Float
    let longitude: Float
    let timezone: String
    let weathercode: Int
}
