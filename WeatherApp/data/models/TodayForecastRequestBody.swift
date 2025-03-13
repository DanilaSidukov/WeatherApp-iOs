import Foundation

struct TodayForecastRequestBody{
    
    let latitude: Float
    let longitude: Float
    let timezone: String
    let startDate: DateFormatter
    let endDate: DateFormatter
    let hourly: String = "temperature_2m,relativehumidity_2m,precipitation,rain,snowfall,weathercode,cloudcover_mid"
    let currentWeather: Bool = true
}
