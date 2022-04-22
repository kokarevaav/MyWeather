import UIKit

class ViewController: UIViewController {

    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var feelTemperature: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeather(city: "Minsk")
    }
    
    @IBAction func searchPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert)
    }
    
}

