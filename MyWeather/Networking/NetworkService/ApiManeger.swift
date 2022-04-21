import Foundation

enum ApiType {
    var baseUrl : String {
        return "https://api.openweathermap.org"
    }
    
    case getLocation(city: String)
    case getWeatherInfo(lat: Int, lon: Int)
    
    var headers : [String:String] {
        return [:]
    }
    
    var path : String {
        switch self {
        case .getLocation(let city):
            return "/geo/1.0/direct?q=\(city)&limit=1&appid=1af6d7e00c7fb1701ff5b37908355b14"
        case .getWeatherInfo(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=1af6d7e00c7fb1701ff5b37908355b14"
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

class ApiManeger {
    
    static let apiMeneger = ApiManeger()
    
    func getLocation(city : String, completion : @escaping (Location) -> Void) {
        let request = ApiType.getLocation(city: city).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(String(decoding: data!, as: UTF8.self))
        }
        task.resume()
    }
}

