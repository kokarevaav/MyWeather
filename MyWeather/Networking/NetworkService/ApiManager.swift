import Foundation

enum ApiType {
    var baseUrl : String {
        return "https://api.openweathermap.org"
    }
    
    case getLocation(city: String)
    case getWeatherInfo(lat: Double, lon: Double)
    
    var headers : [String:String] {
        return [:]
    }
    
    var path : String {
        switch self {
        case .getLocation(let city):
            return "/geo/1.0/direct?q=\(city)&limit=1&appid=1af6d7e00c7fb1701ff5b37908355b14"
        case .getWeatherInfo(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=1af6d7e00c7fb1701ff5b37908355b14"
        }
    }
    
    var request : URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseUrl)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        return request
    }
}

class ApiManager {
    
    static let apiManager = ApiManager()
    
    func getLocation(city : String, completion : @escaping (Location) -> Void) {
        let request = ApiType.getLocation(city: city).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let location = try? JSONDecoder().decode(Location.self, from: data) {
                completion(location)
            } else {
                completion([])
            }
        }
        task.resume()
    }
    
    func getTemperature(city : String, completion : @escaping (Weather?) -> Void) {
        getLocation(city: city) { location in
            if (!location.isEmpty) {
                let request = ApiType.getWeatherInfo(lat: location[0].lat!, lon: location[0].lon!).request
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data, let weather = try? JSONDecoder().decode(Weather.self, from: data) {
                        completion(weather)
                    }
                    else {
                        completion(nil)
                    }
                    //print(String(decoding: data!, as: UTF8.self))
                }
                task.resume()
            }
            else {
                completion(nil)
            }
        }
    }
}
    
    


