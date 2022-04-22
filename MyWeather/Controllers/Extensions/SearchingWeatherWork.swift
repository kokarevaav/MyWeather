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
        ApiManager.apiManager.getTemperature(city: city) { weather in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.temperature.text = String(Int(round(weather.main!.temp!)))
                    self.feelTemperature.text = String(Int(round(weather.main!.feelsLike!))) + "°C"
                    self.city.text = city
                }
            }
            else {
                DispatchQueue.main.async {
                    self.presentError(withTitle: "Oops...", message: "Сheck the correctness of the input", style: .alert)
                }
            }
        }
    }
}

