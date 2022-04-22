import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Minsk"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard var cityName = textField?.text else {
                self.presentError(withTitle: "Oops...", message: "Please try again", style: .alert)
                return
            }
            cityName.removeAll(where: { !Character(extendedGraphemeClusterLiteral: $0).isLetter })
            cityName = cityName.lowercased()
            cityName = cityName.capitalized
            if (cityName != "") {
                self.displayWeather(city: cityName)
            }
            else {
                self.presentError(withTitle: "Oops...", message: "Please try again", style: .alert)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
        
    }
    
    func presentError(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
    
    func displayWeather(city : String){
        ApiManager.apiManager.getTemperature(city: city) { weather, location in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.temperature.text = String(Int(round(weather.main!.temp!)))
                    self.feelTemperature.text = String(Int(round(weather.main!.feelsLike!))) + "°C"
                    self.city.text = location![0].name!
                    self.weatherIcon.image = UIImage(systemName: self.getWeatherImage(weather: weather))
                }
            }
            else {
                DispatchQueue.main.async {
                    self.presentError(withTitle: "Oops...", message: "Сheck the correctness of the input", style: .alert)
                }
            }
        }
    }
    
    func getWeatherImage(weather : Weather) -> String {
        switch weather.weather![0].main {
        case "Thunderstorm" :
            return "cloud.bolt.rain.fill"
        case "Drizzle" :
            return "cloud.drizzle.fill"
        case "Rain" :
            return "cloud.rain.fill"
        case "Snow" :
            return "cloud.snow.fill"
        case "Dust", "Sand", "Ash" :
            return "smoke.fill"
        case "Squall", "Tornado" :
            return "tornado.fill"
        case "Clear" :
            return "sun.max.fill"
        case "Clouds" :
            return "cloud.sun.fill"
        default :
            return "cloud.fog.fill"
        }
    }
}

